import 'dart:convert';

class ShopDetails {
  final String id;
  final String gst;
  final String phoneNumber;
  final List<double> location;
  final bool verificationStatus;

  ShopDetails(
      {this.id,
      this.gst,
      this.phoneNumber,
      this.location,
      this.verificationStatus});

  ShopDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        gst = json['gst'],
        location = List<String>.from(json['location']).map((e) => double.parse(e)).toList(),
        verificationStatus = json['verificationStatus'],
        phoneNumber = json['phoneNumber'];
}
