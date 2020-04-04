from django.db import models
from django.conf import settings

class Hospital(models.Model):
    hospitalname = models.CharField(max_length = 100)
    hospitalno = models.CharField(max_length = 15)

    lat = models.FloatField()
    loc = models.FloatField()

    def __str__(self):
        return str(str(self.id) + " " + str(self.hospitalname))

# Create your models here.
class Pharmacy(models.Model):
    pharmacyname = models.CharField(max_length = 100)
    pharmacyno = models.CharField(max_length = 15)

    lat = models.FloatField()
    loc = models.FloatField()

    def __str__(self):
        return str(str(self.id) + " " + str(self.pharmacyname) )
