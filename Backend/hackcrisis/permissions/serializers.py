from rest_framework import serializers
from . models import Permissions
from users.models import CustomUser,People

class PermissionsSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Permissions.objects.create(**validated_data)
    class Meta:
        model = Permissions
        fields = '__all__'

