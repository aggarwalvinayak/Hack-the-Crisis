from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from django.conf import settings

from .managers import CustomUserManager


class CustomUser(AbstractBaseUser, PermissionsMixin):
    phoneno= models.CharField(max_length = 15,unique = True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    date_joined = models.DateTimeField(default=timezone.now)

    firstname = models.CharField(max_length = 50)
    lastname = models.CharField(max_length = 50)

    USERNAME_FIELD = 'phoneno'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.phoneno

class People(models.Model):

    user = models.ForeignKey(
            settings.AUTH_USER_MODEL,
            on_delete=models.CASCADE,
        )
    aadharno =  models.CharField(max_length = 14)
    lastloc = models.CharField(max_length = 50)
    district =  models.CharField(max_length = 50)
    tag = models.IntegerField()

    def __str__(self):
            return self.user.phoneno
