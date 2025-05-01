from django.db import models


class searchBus(models.Model):
   bus_name=models.CharField(max_length=50)
   from_source=models.CharField(max_length=50)
   to_desti=models.CharField(max_length=50)
   via_city=models.CharField(max_length=50, null=True)
   from_time=models.TimeField(auto_now_add=False)
   to_time=models.TimeField(auto_now_add=False)
   departure_date=models.DateField()
   arrival_date=models.DateField()
   bus_ac=models.BooleanField()
   bus_nonac=models.BooleanField()
   bus_ac_check_text=models.CharField(max_length=10, null=True)
   bus_sleeper_seater_text=models.CharField(max_length=10, null=True)
   bus_price=models.IntegerField()
   bus_seat=models.IntegerField()
   bus_occupy_seat=models.IntegerField()
   seater=models.BooleanField()
   sleeper=models.BooleanField()
   booked_seat_numbers = models.TextField(blank=True, default='') 