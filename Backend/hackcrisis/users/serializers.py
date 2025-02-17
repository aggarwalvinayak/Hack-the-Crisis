from rest_framework import serializers
from . models import CustomUser,People,ZoneAdmin


class CustomUserSerializer(serializers.ModelSerializer):

    firstname = serializers.CharField()
    lastname = serializers.CharField()
    phoneno= serializers.CharField()

    def create(self, validated_data):
        return CustomUser.objects.create(**validated_data)

    class Meta:
        model = CustomUser

        fields = ('firstname','lastname','phoneno')

class ZoneAdminSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return ZoneAdmin.objects.create(**validated_data)
    class Meta:
        model = ZoneAdmin
        fields = '__all__'

class PeopleSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer(read_only = True)

    def create(self, validated_data):
        return People.objects.create(**validated_data)
    class Meta:
        model = People
        fields = '__all__'