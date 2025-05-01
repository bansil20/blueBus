from django.contrib import admin
from django.urls import path
from blueBus import views

urlpatterns = [
    path("",views.index,name='index'),                                   #first bus page splash screen
    path("dashboard",views.dashboard,name='dashboard'),                  #bus booking dashboard
    path("loginreg",views.loginreg,name='loginreg'),                     #login/reg
    path("logoutpage",views.logoutpage,name='logoutpage'),               #logout
    path("search",views.search,name='search'),                           #search
    path('book_seats/<int:bus_id>/', views.book_seats, name='book_seats'),  #book
    path("tic_payment/<int:busId>/",views.tic_payment,name='tic_payment'),  #tic show
    path("send_payment_confirmation/<int:busId>/",views.send_payment_confirmation,name='send_payment_confirmation'),#email

    path("demo",views.demo,name='demo'),                                 #extra no use demo
]
