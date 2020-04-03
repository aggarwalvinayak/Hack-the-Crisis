from django.contrib import admin
from .models import Item,Shop,Order

# Register your models here.
class ItemAdmin(admin.ModelAdmin):
    list_display = ('itemname', 'price', 'quantity_max','shop','description','categ')
class ShopAdmin(admin.ModelAdmin):
    list_display = ('shopname','gst_no','categ','user','isverify','lat','loc')
class OrderAdmin(admin.ModelAdmin):
    list_display = ('item','shop','person','status')

admin.site.register(Item,ItemAdmin)
admin.site.register(Order,OrderAdmin)
admin.site.register(Shop,ShopAdmin)