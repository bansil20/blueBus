from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.shortcuts import render, redirect,HttpResponse
from django.contrib import messages
from blueBus.models import searchBus
from datetime import datetime,timedelta
from django.db.models import Q
from django.utils import timezone
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.db import transaction

import qrcode
from io import BytesIO
import base64



from django.core.mail import send_mail
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings



def index(request):
    return render(request,'index.html')              #first bus page splash screen





def dashboard(request):  

    # Get the current date
    current_date = timezone.now().date()

    # Fetch all bus data
    buses = searchBus.objects.all()

    # Update buses with past departure dates
    for bus in buses:
        if bus.departure_date and bus.departure_date < current_date:
            # Calculate the time difference between from_time and to_time
            if bus.from_time and bus.to_time:
                departure_datetime = datetime.combine(bus.departure_date, bus.from_time)
                arrival_datetime = datetime.combine(bus.arrival_date, bus.to_time)
                time_diff = arrival_datetime - departure_datetime

                # Update the departure date to the current date
                new_departure_datetime = datetime.combine(current_date, bus.from_time)
                new_arrival_datetime = new_departure_datetime + time_diff

                # Update the bus dates in the database
                bus.departure_date = new_departure_datetime.date()
                bus.arrival_date = new_arrival_datetime.date()
                bus.save()  # Save changes to the database

    # Get all 'from_source' and 'to_desti' values for the dropdown
    all_sources = searchBus.objects.values_list('from_source', flat=True).distinct()
    all_destinations = searchBus.objects.values_list('to_desti', flat=True).distinct()

    
    selected_from_source = request.GET.get('from_source')
    selected_to_desti = request.GET.get('to_desti')
    selected_departure_date = request.GET.get('dept_date')

    return render(request, 'dashboard.html', {
        'all_sources': all_sources,
        'all_destinations': all_destinations,
        'selected_from_source': selected_from_source,
        'selected_to_desti': selected_to_desti,
        'selected_departure_date': selected_departure_date, 
    })


def loginreg(request):
    previous_page = request.POST.get('previous_page', '/')

    if request.method == 'POST':
        if 'login' in request.POST: 
            username = request.POST['username']
            password = request.POST['password']

            # Authenticate the user
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)  # Log the user in

                # Retrieve the previous page from the form or default to the search page
                previous_page = request.POST.get('previous_page', 'search')

                return redirect(previous_page)
            else:
                messages.error(request, 'Invalid credentials')
                return redirect('loginreg') 

        elif 'register' in request.POST: 
            username = request.POST['regname']
            password1 = request.POST['regpass']
            password2 = request.POST['reregpass']

            # Check if passwords match
            if password1 == password2:
                if User.objects.filter(username=username).exists():
                    messages.error(request, 'Username already exists')
                else:
                    # Create the new user
                    user = User.objects.create_user(username=username, password=password1)
                    user.save()
                    login(request, user)  # Automatically log in the user after registration

                    return redirect('dashboard')
            else:
                messages.error(request, "Passwords do not match")
                return redirect('loginreg')

   
    return render(request, 'loginreg.html')


def logoutpage(request):
    logout(request)
    return redirect('dashboard')





def book_seats(request, bus_id):
    
        selected_seats = request.POST.get('selected_seats')

        if not selected_seats:
            return JsonResponse({"error": "Invalid request. Missing selected seats data."}, status=400)

        bus = get_object_or_404(searchBus, id=bus_id)

        print(f'bus {bus}')

        # Parse selected seats into a list of integers
        selected_seat_list = sorted([int(seat) for seat in selected_seats.split(',') if seat.strip().isdigit()])


        # Retrieve already booked seats as a list of integers
        booked_seat_list = [
            int(seat) for seat in (bus.booked_seat_numbers or "").split(',') if seat.strip().isdigit()
        ]

        # Check for conflicts
        conflicting_seats = [seat for seat in selected_seat_list if seat in booked_seat_list]
        if conflicting_seats:
            return JsonResponse(
                {"error": "The following seats are already booked.", "conflicts": conflicting_seats},
                status=400
            )

        # Update the list of booked seats
        updated_seat_list = sorted(set(booked_seat_list + selected_seat_list))
        updated_seat_list_str = ','.join(map(str, updated_seat_list))

        try:
            # Use atomic transaction to ensure data consistency
            with transaction.atomic():
                # Save the updated booked seats and occupied seat count
                bus.booked_seat_numbers = updated_seat_list_str
                bus.bus_occupy_seat = len(updated_seat_list)
                bus.save()

            # return JsonResponse({"success": "Seats booked successfully", "booked_seats": updated_seat_list}, status=200) # -------aaya page add karvamu
            return redirect('dashboard')
            
        except Exception as e:
            return JsonResponse({"error": f"Error saving bus data: {str(e)}"}, status=500)



def search(request):
    # Retrieve filter values from the session if the user is authenticated
    from_source_filter = request.POST.get('from_source', request.session.get('from_source'))
    to_desti_filter = request.POST.get('to_desti', request.session.get('to_desti'))
    selected_departure_date = request.POST.get('dept_date', request.session.get('dept_date'))

    # Clear session data after using it
    request.session['from_source'] = from_source_filter
    request.session['to_desti'] = to_desti_filter
    request.session['dept_date'] = selected_departure_date

    # Convert selected_departure_date to a date object
    if selected_departure_date:
        selected_departure_date = timezone.datetime.strptime(selected_departure_date, '%d-%m-%Y').date()

    # Fetch all bus data
    searchBusData = searchBus.objects.all()

    # Get all 'from_source' and 'to_desti' values for debugging
    all_sources = searchBus.objects.values_list('from_source', flat=True).distinct()
    all_destinations = searchBus.objects.values_list('to_desti', flat=True).distinct()

    # Apply filters for from_source, to_desti, and via_city
    if from_source_filter and to_desti_filter:
        searchBusData = searchBusData.filter(
            (Q(from_source=from_source_filter) | Q(via_city=from_source_filter)) & 
            Q(to_desti=to_desti_filter)
        )

    # Apply departure date filter
    if selected_departure_date:
        searchBusData = searchBusData.filter(departure_date=selected_departure_date)

    bus_ac_filter = request.POST.get('bus_ac')
    bus_nonac_filter = request.POST.get('bus_nonac')
    sleeper_filter = request.POST.get('sleeper')
    seater_filter = request.POST.get('seater')

     # Clear session data after using it
    request.session['bus_ac'] = bus_ac_filter
    request.session['bus_nonac'] = bus_nonac_filter
    request.session['sleeper'] = sleeper_filter
    request.session['seater'] = seater_filter

    # Apply the bus type filters
    if bus_ac_filter == "1" and bus_nonac_filter == "1":
        pass 
    elif bus_ac_filter == "1":
        searchBusData = searchBusData.filter(bus_ac=True)
    elif bus_nonac_filter == "1":
        searchBusData = searchBusData.filter(bus_nonac=True)

    # Apply the seat type filters
    if sleeper_filter == "1" and seater_filter == "1":
        pass 
    elif sleeper_filter == "1":
        searchBusData = searchBusData.filter(sleeper=True)
    elif seater_filter == "1":
        searchBusData = searchBusData.filter(seater=True)

    # Calculate time difference, available seats, and adjust price and departure time for each bus
    for bus in searchBusData:
        
        if bus.departure_date and bus.arrival_date and bus.from_time and bus.to_time:
            departure_datetime = datetime.combine(bus.departure_date, bus.from_time)
            arrival_datetime = datetime.combine(bus.arrival_date, bus.to_time)
            time_diff = arrival_datetime - departure_datetime
            hours, remainder = divmod(time_diff.total_seconds(), 3600)
            minutes = remainder // 60
            bus.time_difference = f"{int(hours)}h {int(minutes)}m"
        else:
            bus.time_difference = "N/A"

        # Calculate available seats
        if bus.bus_seat is not None and bus.bus_occupy_seat is not None:
            bus.available_seats = bus.bus_seat - bus.bus_occupy_seat
        else:
            bus.available_seats = "N/A"

        # Adjust departure time and price if searching from a via city
        if from_source_filter and bus.via_city and from_source_filter.strip().lower() == bus.via_city.strip().lower():
            time_to_reach_via_city = timedelta(hours=8)
            new_departure_datetime = departure_datetime + time_to_reach_via_city
            new_time_diff = arrival_datetime - new_departure_datetime
            hours, remainder = divmod(new_time_diff.total_seconds(), 3600)
            minutes = remainder // 60
            bus.time_difference = f"{int(hours)}h {int(minutes)}m"
            bus.departure_date = new_departure_datetime.date()
            bus.from_time = new_departure_datetime.time()
            bus.bus_price *= 0.5 


    
    data = {
        'searchBusData': searchBusData,
        'all_sources': all_sources,
        'all_destinations': all_destinations,
        'selected_from_source': from_source_filter,
        'selected_to_desti': to_desti_filter,
        'selected_departure_date': selected_departure_date.strftime('%d-%m-%Y') if selected_departure_date else None,
    }

    return render(request, 'search.html', data)





def tic_payment(request,busId):
    print(f"busIdbusIdbusIdbusId: {busId}")

    # Retrieve the data from the form submission
    bus_name = request.POST.get('bus_name')
    from_source = request.POST.get('from_source')
    to_desti = request.POST.get('to_desti')
    departure_time = request.POST.get('from_time')
    arrival_time = request.POST.get('to_time')
    bus_price = request.POST.get('bus_price')
    selected_seats = request.POST.get('selected_seats', '')
    bus_ac_check_text = request.POST.get('bus_ac_check_text')
    bus_sleeper_seater_text = request.POST.get('bus_sleeper_seater_text')

    selected_seats_list = selected_seats.split(',') if selected_seats else []


     
    print(f"Bus Name: {bus_name}, From: {from_source}, To: {to_desti}")
    print(f"Departure Time: {departure_time}, Arrival Time: {arrival_time}")
    print(f"Selected Seats: {selected_seats_list}")
    print(f"bus_ac: {bus_ac_check_text}")
    print(f"bus_sleeper_seater_text: {bus_sleeper_seater_text}")

    # Calculate total fare 
    num_passengers = len(selected_seats_list)
    current_date = timezone.now().date()
    gst = float(bus_price) * 0.1
    grand_total = float(bus_price) + gst
    range_pass = range(num_passengers)



    # UPI payment link
    merchant_upi_id = "bansilpabari20@okicici"
    transaction_note = f"blueBus Booking for {from_source} to {to_desti}"
    transaction_id = f"TXN{int(timezone.now().timestamp())}"
    
    upi_url = f"upi://pay?pa={merchant_upi_id}&pn=BusBooking&tn={transaction_note}&am={grand_total}&cu=INR&tid={transaction_id}"

    # Generate the payment QR code based on the grand total and UPI link
    qr_img = qrcode.make(upi_url)

    # Save the QR code as an image in memory
    qr_buffer = BytesIO()
    qr_img.save(qr_buffer)
    qr_buffer.seek(0)

    # Convert the QR code image buffer to Base64 string
    qr_base64 = base64.b64encode(qr_buffer.getvalue()).decode('utf-8')


    data = {
        'bus_name': bus_name,
        'from_source': from_source,
        'to_desti': to_desti,
        'departure_time': departure_time,
        'arrival_time': arrival_time,
        'selected_seats': selected_seats_list,
        'passengers': num_passengers,
        'bus_price': bus_price,
        'bus_ac_check_text': bus_ac_check_text,
        'bus_sleeper_seater_text': bus_sleeper_seater_text,
        'range_passenger': range_pass,
        'gst': int(gst),
        'grand_total': int(grand_total),
        'currentDate': current_date,
        'qr_code': qr_base64, 
        'upi_url': upi_url, 
        'busId': busId,


    }

    return render(request, 'tic_payment.html', data)



@csrf_exempt
def send_payment_confirmation(request,busId):
   
        user_email = request.POST.get('email')
        user_phone = request.POST.get('phone')
        selected_seats = request.POST.get('seat')
        from_source = request.POST.get('from_source')
        to_desti = request.POST.get('to_desti')

        if not user_email or not user_phone:
            return HttpResponse('Email or phone number is missing.', status=400)

        # Prepare email content
        subject = 'Payment Confirmation - Ticket Booked'
        message = (
            f"Dear Customer,\n\n"
            f"Your payment was successfully received. Thank you for booking with us!\n\n"
            f"Your seat number is/are {selected_seats}\n\n"
            f"Your destination is {from_source} to {to_desti}\n\n"
            f"Contact: +91 8780954895\n\n"
            f"Best regards,\nblueBus Team"
        )
        from_email = settings.DEFAULT_FROM_EMAIL

        # Send email using Django's send_mail
        try:
            send_mail(subject, message, from_email, [user_email], fail_silently=False)
        except Exception as e:
            return HttpResponse(f"Error sending email: {str(e)}", status=500)

        return book_seats(request, busId) 





def demo(request):
    return render(request,'demo.html')










