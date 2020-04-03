from django.contrib import admin
from . models import CustomUser,People
# Register your models here.

class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('phoneno', 'firstname', 'lastname')
class PeopleAdmin(admin.ModelAdmin):
    list_display = ('aadharno','district','tag')

admin.site.register(CustomUser,CustomUserAdmin)
admin.site.register(People,PeopleAdmin)