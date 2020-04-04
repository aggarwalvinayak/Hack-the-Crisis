from django.db import models
from django.conf import settings

class Permissions(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    areaassoc = models.CharField(max_length = 100)
    permreason = models.CharField(max_length = 200)
    status = models.CharField(max_length = 20)
    date = models.CharField(max_length = 30)
    starttime = models.CharField(max_length = 30)
    endtime = models.CharField(max_length = 30)

    def __str__(self):
        return str(str(self.id) + " " + str(self.user.phoneno))
