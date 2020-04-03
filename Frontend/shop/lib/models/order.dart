enum Status { PENDING, APPROVED, COMPLETED }

class Order {
  //Orders (Item#, Shop#, Aadhar#, ToLoc, DeliveryStatus, Quantity)
  final List<String> itemId;
  final String shopId;
  final String aadharNo;
  final List<int> quantity;
  final Status status; //String strStatus = status.toString().split('.').last;
  final String toLocation;

  Order.fromJson(Map<String, dynamic> json)
      : itemId = json['itemId'],
        shopId = json['shopId'],
        aadharNo = json['aadharNo'],
        quantity = json['quantity'],
        status =
            Status.values.firstWhere((element) => element.toString().split('.').last == json['status']),
        toLocation = json['toLocation'];
}
