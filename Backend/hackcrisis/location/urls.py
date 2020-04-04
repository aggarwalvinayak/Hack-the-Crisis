from django.urls import path

from .views import ClosestHospitalApi,ClosestPharmacyApi
from . import views


app_name = "location"

# app_name will help us do a reverse look-up latter.
urlpatterns = [
	path('closesthospital/',  ClosestHospitalApi.as_view()),
	path('closestpharmacy/',ClosestPharmacyApi.as_view()),
]
