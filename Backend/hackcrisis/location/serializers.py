from rest_framework import serializers
from . models import Hospital,Pharmacy

class HospitalSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Hospital.objects.create(**validated_data)
    class Meta:
        model = Hospital
        fields = '__all__'

class PharmacySerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Pharmacy.objects.create(**validated_data)
    class Meta:
        model = Pharmacy
        fields = '__all__'