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
		phone = request.POST.get('phone') 

		shop=Shop(shopname=shopname,gst_no=gst_no,categ=categ,isverify=0,user=CustomUser.objects.get(phoneno=phone))
		shop.save()
		return Response("Succeess")

class OrderList(APIView):
	def get(self,request):
		shop = request.GET.get('gst')
		status = request.GET.get('status')
		shopss= Order.objects.filter(shop=Shop.objects.get(gst_no=shop))
		shopss=shopss.filter(status=status)
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
		shopss=Item.objects.filter(shop=Shop.objects.get(gst_no=request.GET.get('gst')))
		serializer = ItemSerializer(shopss,many = True)

		return Response(serializer.data)

	def post(self,request):#only one entry per post request
		itemname = request.POST.get('name')
		price = request.POST.get('price')
		quantity_max = request.POST.get('quant')
		shop = Shop.objects.get(gst_no=request.POST.get('gst'))
		description=request.POST.get('desc')
		product=Item(itemname=itemname,price=price,description=description,shop=shop,quantity_max=quantity_max)
		product.save()
		return Response("Item Added")

class ClosestShop(APIView):

	def get(self,request):

		lat = float(request.GET.get('lat'))
		lon = float(request.GET.get('lon'))
		
		nautical_mile = 1.852

		shops = Shop.objects.filter(lat__range=(lat-nautical_mile*3,lat+nautical_mile*3),loc__range =(lon-nautical_mile*3,lon+nautical_mile*3))
		serializer = ShopSerializer(shops,many = True)

		return Response(serializer.data)

	def post(self,request):#only one entry per post request
		return Response("ClosestShop APIView")
