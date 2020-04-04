import 'dart:convert';

class ShopDetails {
  final String id;
  final String gst;
  final String shopName;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String category;
  final bool verificationStatus;

  ShopDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        gst = json['gst'].toString(),
        firstName = json['firstName'],
        lastName = json['lastName'],
        category = json['category'],
        verificationStatus = json['verificationStatus'],
        shopName = json['shopName'],
        phoneNumber = json['phoneNumber'].toString();
}
