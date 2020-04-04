from django.shortcuts import render,redirect
import json
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from . serializers import ItemSerializer,ShopSerializer,OrderSerializer
import requests
from .models import Shop,Item,Order

from django.contrib.auth import authenticate,login
from users.models import CustomUser
import time
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, renderer_classes


class ShopList(APIView):
	def get(self,request):
		shopss=Shop.objects.all()
		serializer = ShopSerializer(shopss,many = True)

		return Response(serializer.data)
	def post(self,request):
		shopname = request.POST.get('name')
		gst_no = request.POST.get('gst')
		categ = request.POST.get('cat')
		lat = request.POST.get('lat')
		lon = request.POST.get('lon')
		phn = request.POST.get('phone') 

		shop=Shop(shopname=shopname,gst_no=gst_no,categ=categ,isverify=0,user=CustomUser.objects.get(phoneno=phone))
		shop.save()
		return Response("Succeess")

class OrderList(APIView):
	def get(self,request):
		shopss=Order.objects.all()
		serializer = OrderSerializer(shopss,many = True)

		return Response(serializer.data)

	def post(self,request):
		orderno = (Order.objects.order_by('-id')[0]).orderno + 1
		shop = Shop.objects.get(pk=request.POST.get('shop'))
		item = request.POST.get('item')
		quant = request.POST.get('quant')
		user = CustomUser.objects.get(phoneno=request.POST.get('phone'))
		status = "Received"

		items=item[1:-1].split(',')
		quants=quant[1:-1].split(',')
		if(item):
			for i in range(len(items)):
				ord =Order(orderno=orderno,shop=shop,item=items[i],quant=quants[i],person=user,status=status)
				ord.save()
		
		return Response("Succeess")


class ItemList(APIView):

	def get(self,request):
		shopss=Item.objects.all()
		serializer = ItemSerializer(shopss,many = True)

		return Response(serializer.data)

	def post(self,request):#only one entry per post request
		itemname = request.POST.get('name')
		price = request.POST.get('price')
		quantity_max = request.POST.get('quant')
		shop = Shop.objects.get(pk=request.POST.get('shop'))
		description=request.POST.get('desc')
		categ = request.POST.get('cat')
		product=Item(itemname=itemname,categ=cat,price=price,description=description,shop=shop,quantity_max=quantity_max)
		product.save()
		return Response("Item Added")