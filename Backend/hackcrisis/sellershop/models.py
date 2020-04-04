from django.db import models
from django.conf import settings
from users.models import People

class Shop(models.Model):
	shopname = models.CharField(max_length = 100)
	gst_no = models.IntegerField()
	categ = models.CharField(max_length = 100)
	user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
	isverify = models.IntegerField()
	lat = models.FloatField()
	loc = models.FloatField()

	def __str__(self):
		return str(str(self.id) + " " + str(self.shopname))

# Create your models here.
class Item(models.Model):
	itemname = models.CharField(max_length = 100)
	price = models.IntegerField()
	quantity_max = models.CharField(max_length = 100)
	shop = models.ForeignKey(Shop,on_delete=models.CASCADE)
	description = models.TextField()

	def __str__(self):
		return str(str(self.id) + " " + str(self.itemname) )

class Order(models.Model):
	orderno = models.IntegerField()
	item = models.ForeignKey(Item,on_delete=models.CASCADE)
	shop = models.ForeignKey(Shop,on_delete=models.CASCADE)
	person = models.ForeignKey(People,on_delete=models.CASCADE)
	status = models.CharField(max_length = 100)
	def __str__(self):
		return str(str(self.id) + " " + str(self.orderno))	

