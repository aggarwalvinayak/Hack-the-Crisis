from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import ugettext_lazy as _


class CustomUserManager(BaseUserManager):
    """
    Custom user model manager where phoneno is the unique identifiers
    for authentication instead of usernames.
    """
    def create_user(self, phoneno, password, **extra_fields):
        """
        Create and save a User with the given phoneno and password.
        """
        if not phoneno:
            raise ValueError(_('The phoneno must be set'))
        user = self.model(phoneno=phoneno, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, phoneno, password, **extra_fields):
        """
        Create and save a SuperUser with the given phoneno and password.
        """
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))
        return self.create_user(phoneno, password, **extra_fields)