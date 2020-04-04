from django.shortcuts import render,redirect
import json
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from . serializers import HospitalSerializer,PharmacySerializer
import requests
from .models import Hospital,Pharmacy

from django.contrib.auth import authenticate,login
import time
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, renderer_classes

class ClosestHospitalApi(APIView):

    def get(self,request):

        lat = float(request.GET.get('lat'))
        lon = float(request.GET.get('lon'))
        
        nautical_mile = 1.852

        hosp = Hospital.objects.filter(lat__range=(lat-nautical_mile*3,lat+nautical_mile*3),loc__range =(lon-nautical_mile*3,lon+nautical_mile*3))
        serializer = HospitalSerializer(hosp,many = True)

        return Response(serializer.data)

    def post(self,request):#only one entry per post request
        return Response("ClosestHospital APIView")

class ClosestPharmacyApi(APIView):

    def get(self,request):
        lat = float(request.GET.get('lat'))
        lon = float(request.GET.get('lon'))
        
        nautical_mile = 1.852

        pharm = Pharmacy.objects.filter(lat__range=(lat-nautical_mile*3,lat+nautical_mile*3),loc__range =(lon-nautical_mile*3,lon+nautical_mile*3))
        serializer = PharmacySerializer(pharm,many = True)

        return Response(serializer.data)

    def post(self,request):#only one entry per post request
        return Response("ClosestPharmacy APIView")
