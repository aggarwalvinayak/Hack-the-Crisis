from django.db import models
from users.models import ZoneAdmin

class NewsTable(models.Model):

	district =  models.CharField(max_length = 50)
	title = models.CharField(max_length = 50)
	description = models.CharField(max_length = 200)
	link = models.CharField(max_length = 20)

	def __str__(self):
			return self.district + " " + self.title

class Announcements(models.Model):

	zoneadmin = models.ForeignKey(ZoneAdmin,on_delete=models.CASCADE)
	district =  models.CharField(max_length = 50)
	title = models.CharField(max_length = 50)
	description = models.CharField(max_length = 200)

	def __str__(self):
			return str(str(self.id)) + " " + self.title
