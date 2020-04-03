enum Status { PENDING, APPROVED, COMPLETED }

class Order {
  //Orders (Item#, Shop#, Aadhar#, ToLoc, DeliveryStatus, Quantity)
  final String itemId;
  final String shopId;
  final String aadharNo;
  final int quantity;
  final Status status; //String strStatus = status.toString().split('.').last;
  final List<String> toLocation;

  Order.fromJson(Map<String, dynamic> json)
      : itemId = json['itemId'],
        shopId = json['shopId'],
        aadharNo = json['aadharNo'],
        quantity = int.parse(json['quantity']),
        status =
            Status.values.firstWhere((element) => element == json['status']),
        toLocation = json['location'];
}
