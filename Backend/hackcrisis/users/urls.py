from django.urls import path

from .views import LoginApi,RegisterApi
from . import views


app_name = "mainapp"

# app_name will help us do a reverse look-up latter.
urlpatterns = [
	path('loginapi/',  LoginApi.as_view()),
	path('registerapi/',RegisterApi.as_view()),
]
