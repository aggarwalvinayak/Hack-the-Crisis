from django.shortcuts import render,redirect
import json
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from . serializers import PermissionsSerializer
import requests
from .models import Permissions

from django.contrib.auth import authenticate,login
from users.models import CustomUser
import time
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, renderer_classes


class PermissionsList(APIView):
    def get(self,request):
        perm=Permissions.objects.all()
        serializer = PermissionsSerializer(perm,many = True)

        return Response(serializer.data)
    def post(self,request):
        phoneno = request.POST.get('phone')
        areaassoc = request.POST.get('areaassoc')
        permreason = request.POST.get('permreason')
        status = request.POST.get('status')
        date = request.POST.get('date')
        starttime = request.POST.get('starttime')
        endtime = request.POST.get('endtime')

        perm,created = Permissions.objects.get_or_create(user=CustomUser.objects.get(phoneno=phoneno))
        perm.areaassoc = areaassoc
        perm.permreason = permreason
        perm.status = status
        perm.date = date
        perm.starttime = starttime
        perm.endtime = endtime

        perm.save()
        return Response("Succeess")
