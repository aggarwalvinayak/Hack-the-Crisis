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

class Updatetag(APIView):
    def post(self,request):
        ad = request.POST.get('aadhar')
        tg = request.POST.get('new_tag')
        user = People.objects.get(aadharno=ad)
        user.tag=tg
        user.save()
        return Response("Changed")


class Locationred(APIView):
    def get(self,request):
        peop= People.objects.filter(tag=1)
        serializer = PeopleSerializer(peop,many = True)
        return Response(serializer.data)

class LoginApi(APIView):
    
    def get(self,request):
        # print(request.data.get('aadhar'))
        people = People.objects.filter(aadharno=request.GET.get('aadhar'))
        serializer = PeopleSerializer(people,many = True)
        print(people)
        return Response(serializer.data)

    def post(self,request):
        username = request.data.get('phoneno')
        password = request.data.get('password')
        login_type = int(request.data.get('type'))
        print(username,password)
        user = authenticate(username=username, password=password)

        if user is not None:

            if login_type == 1:
                people = People.objects.filter(user=user)[0]
                contextfrontend  = {"phoneno":user.phoneno,"firstname":user.firstname,
                        "lastname":user.lastname,"aadharno":people.aadharno,"tag":people.tag}
            elif login_type == 2:
                seller = Shop.objects.filter(user=user)[0]
                contextfrontend  = {"phoneno":user.phoneno,"firstname":user.firstname,
                        "lastname":user.lastname,"shopname":seller.shopname,"gst_no":seller.gst_no,"categ":seller.categ}
            else:
                zoneadmin = ZoneAdmin.objects.filter(user=user)[0]
                contextfrontend  = {"phoneno":user.phoneno,"firstname":user.firstname,
                        "lastname":user.lastname,"district":zoneadmin.district,"id":zoneadmin.id}
            return Response(contextfrontend)

        else:
            return Response({"F"})

class RegisterApi(APIView):
    
    def get(self,request):
        return Response("Register APIView")

    def post(self,request):
        f_phoneno = request.data.get('phoneno')
        f_password = request.data.get('password')
        f_fname = request.data.get('firstname')
        f_lname = request.data.get('lastname')
        login_type = int(request.data.get('type'))
        print()
        print()
        try:
            user,created = CustomUser.objects.get_or_create(phoneno = f_phoneno)

            if created:
                user.firstname = f_fname
                user.lastname = f_lname
                user.set_password(f_password)
                user.save()

            if login_type == 1:
                print(1)
                f_aadharno = request.data.get('aadharno')
                f_lat = request.data.get('lat')
                f_lon = request.data.get('lon')
                f_district = request.data.get('district')
                f_tag = request.data.get('tag')

                people,created = People.objects.get_or_create(user = user)

                if created:
                    people.aadharno =f_aadharno 
                    people.lat =f_lat
                    people.lon =f_lon
                    people.district = f_district
                    people.tag = f_tag
                    people.save()

            elif login_type == 2:
                print(2)
                shopname = request.data.get('name')
                gst_no = request.data.get('gst')
                lat = float(request.data.get('lat'))
                lon = float(request.data.get('lon'))
                categ = request.data.get('cat')
                print(11)
                shop,created = Shop.objects.get_or_create(user = user,gst_no=gst_no,isverify=0,lat=lat,loc=lon,categ=categ,shopname=shopname)
                # print(33)
                # shop.shopname = shopname 
                # print()
                # print()
                # shop.gst_no = gst_no
                # shop.categ = categ
                # shop.isverify = 0
                # shop.lat = lat
                # shop.loc = lon
                shop.save()
            else:
                print(3)
                district = request.data.get('district')

                zoneadmin,created = ZoneAdmin.objects.get_or_create(user = user)

                zoneadmin.district = district
                zoneadmin.save()
            return Response({"Success"})
        except Exception as e:
            print(e)

        return Response({"F"})