from django.db import models

# Create your models here.
class Item(models.Model):
	itemname = models.CharField(max_length = 100)
	price = models.IntegerField()
	quantity_max = models.CharField(max_length = 100)
	shop = models.ForeignKey(Shop,on_delete=models.CASCADE)
	description = models.TextField()
	categ= models.CharField(max_length = 100)

	def __str__(self):
		return str(str(self.id) + " " + str(self.itemname) )

class Shop(models.Model):
	shopname = models.CharField(max_length = 100)
	gst_no = models.IntegerField()
	categ = models.CharField(max_length = 100)
	user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
	isverify = models.IntegerField()
	loc = 
	def __str__(self):
		return str(str(self.id) + " " + str(self.shopname))

class Order(models.Model):
	orderno = models.IntegerField()
	item = models.ForeignKey(item,on_delete=models.CASCADE)
	shop = models.ForeignKey(Shop,on_delete=models.CASCADE)
	person = models.ForeignKey(People,on_delete=models.CASCADE)
	status = models.CharField(max_length = 100)
	def __str__(self):
		return str(str(self.id) + " " + str(self.shop))	

