from django.urls import path

from .views import ShopList,ItemList,OrderList
from . import views


app_name = "sellershop"

# app_name will help us do a reverse look-up latter.
urlpatterns = [
	path('order/',  OrderList.as_view()),
	path('item/',ItemList.as_view()),
	path('shop/',ShopList.as_view()),

]
