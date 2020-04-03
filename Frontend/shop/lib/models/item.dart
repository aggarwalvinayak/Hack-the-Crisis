class Item {
  //Items (Item#, Shop#, type, price, quantity_avl)
  final String id;
  final String shopId;
  final String type;
  final double price;
  final int quantityAvailable;

  Item({this.id, this.shopId, this.type, this.price, this.quantityAvailable});

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        shopId = json['shopId'],
        type = json['type'],
        price = double.parse(json['price']),
        quantityAvailable = int.parse(json['quantityAvailable']);
}
