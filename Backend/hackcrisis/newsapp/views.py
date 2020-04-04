from django.shortcuts import render,redirect
import json
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from . serializers import NewsTableSerializer,AnnouncementsSerializer
import requests
from .models import NewsTable,Announcements
from users.models import ZoneAdmin

from django.contrib.auth import authenticate,login
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, renderer_classes


class NewsTableApi(APIView):
    def get(self,request):
        news=NewsTable.objects.all()
        serializer = NewsTableSerializer(news,many = True)

        return Response(serializer.data)
    def post(self,request):
        district = request.POST.get('district')
        title = request.POST.get('title')
        description = request.POST.get('description')
        link = request.POST.get('link')

        news=NewsTable(district=district,title=title,description=description,link = link)
        news.save()
        return Response("Succeess")

class AnnouncementsApi(APIView):
    def get(self,request):
        news=Announcements.objects.all()
        serializer = AnnouncementsSerializer(news,many = True)

        return Response(serializer.data)
    def post(self,request):
        district = request.POST.get('district')
        title = request.POST.get('title')
        description = request.POST.get('description')
        zoneadmin_id = request.POST.get('id')

        zoneadmin = ZoneAdmin.objects.get(id = zoneadmin_id)

        announce=Announcements(district=district,title=title,description=description,zoneadmin = zoneadmin)
        announce.save()
        return Response("Succeess")
