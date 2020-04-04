from rest_framework import serializers
from . models import NewsTable,Announcements


class NewsTableSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return NewsTable.objects.create(**validated_data)
    class Meta:
        model = NewsTable
        fields = '__all__'

class AnnouncementsSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Announcements.objects.create(**validated_data)
    class Meta:
        model = Announcements
        fields = '__all__'