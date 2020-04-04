class Item {
  //Items (Item#, Shop#, type, price, quantity_avl)
  final String name;
  final String shopId;
  final String description;
  final int price;
  int quantityAvailable;

  Item({this.name, this.shopId, this.price, this.quantityAvailable, this.description});

  get getName {
    return name;
  }

  get getDescription {
    return description;
  }

  get getPrice {
    return price;
  }

  get getQuantityAvailable {
    return quantityAvailable;
  }

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        shopId = json['shopId'],
        price = int.parse(json['price']),
        description = json['description'],
        quantityAvailable = int.parse(json['quantityAvailable']);
}
