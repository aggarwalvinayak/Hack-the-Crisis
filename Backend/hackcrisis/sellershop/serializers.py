from rest_framework import serializers
from . models import Shop,Item,Order
from users.models import CustomUser,People

class ItemSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Item.objects.create(**validated_data)
    class Meta:
        model = Item
        fields = '__all__'

class OrderSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Order.objects.create(**validated_data)

    class Meta:
        model = Order

        fields = '__all__'

class ShopSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        return Shop.objects.create(**validated_data)

    class Meta:
        model = Shop

        fields = '__all__'