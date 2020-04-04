enum Status { PENDING, APPROVED, COMPLETED }

class Order {
  //Orders (Item#, Shop#, Aadhar#, ToLoc, DeliveryStatus, Quantity)
  final String _id;
  final List<String> _itemId;
  final String _shopId;
  final String _aadharNo;
  final List<int> _quantity;
  Status _status; //String strStatus = status.toString().split('.').last;
  final String _toLocation;

  get getStatus {
    return _status;
  }

  get getToLocation {
    return _toLocation;
  }

  get getItemId {
    return _itemId;
  }

  get getQuantity {
    return _quantity;
  }

  void setStatus(Status status) {
    _status = status;
  }

  Order.fromJson(Map<String, dynamic> json)
      : _id = json['id'].toString(),
        _itemId = List<String>.from(json['itemId']),
        _shopId = json['shopId'].toString(),
        _aadharNo = json['aadharNo'].toString(),
        _quantity = List<int>.from(json['quantity']),
        _status =
            Status.values.firstWhere((element) => element.toString().split('.').last == json['status']),
        _toLocation = json['toLocation'];
}
