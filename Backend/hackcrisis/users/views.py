from django.shortcuts import render,redirect
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from django.contrib.auth import authenticate,login

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from . models import CustomUser,People,ZoneAdmin
from sellershop.models import Shop
from .serializers import PeopleSerializer



class Locationred(APIView):
	def get(self,request):
		peop= People.objects.filter(tag=1)
		serializer = PeopleSerializer(peop,many = True)
		return Response(serializer.data)

class LoginApi(APIView):


class RegisterApi(APIView):

