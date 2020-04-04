from django.contrib import admin
from . models import CustomUser,People,ZoneAdmin
# Register your models here.

class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('phoneno', 'firstname', 'lastname')
class PeopleAdmin(admin.ModelAdmin):
    list_display = ('aadharno','district','tag')
class ZoneAdminAdmin(admin.ModelAdmin):
    list_display = ('id','district')

admin.site.register(CustomUser,CustomUserAdmin)
admin.site.register(People,PeopleAdmin)
admin.site.register(ZoneAdmin,ZoneAdminAdmin)