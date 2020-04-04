from django.urls import path

from .views import NewsTableApi,AnnouncementsApi
from . import views


app_name = "mainapp"

# app_name will help us do a reverse look-up latter.
urlpatterns = [
	path('news/',  NewsTableApi.as_view()),
	path('announcements/',AnnouncementsApi.as_view()),
]
