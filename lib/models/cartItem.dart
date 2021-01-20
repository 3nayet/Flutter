import 'dart:core';
import 'dart:convert';


class CartItem{

  String id;
  String name;
  int qty;
  double price;
  String color;
  String size;
  String picture;
  String brand;
  String category;

  CartItem({
    this.id, this.category, this.picture, this.name, this.price, this.size, this.qty,
    this.color, this.brand
});

  String cartItemToJson(CartItem data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  CartItem cartItemFromJson(String str) {
    final jsonData = json.decode(str);
    return CartItem.fromMap(jsonData);
  }

  factory CartItem.fromMap(Map<String, dynamic> json) => new CartItem(
    id: json["id"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"].toDouble(),

    color: json["color"],
    size: json["size"],
    brand: json["brand"],
    category: json["category"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,

    "color": color,
    "category": category,
    "brand": brand,
    "size": size,
    "picture": picture,

  };

}