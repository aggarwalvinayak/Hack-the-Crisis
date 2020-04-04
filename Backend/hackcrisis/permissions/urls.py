from django.urls import path

from .views import PermissionsList
from . import views


app_name = "permissions"

# app_name will help us do a reverse look-up latter.
urlpatterns = [
    path('permissions/',  PermissionsList.as_view()),
    
]
