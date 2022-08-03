import 'dart:convert';

List<Map<String, Product>> productFromJson(String str) =>
    List<Map<String, Product>>.from(json.decode(str).map((x) => Map.from(x)
        .map((k, v) => MapEntry<String, Product>(k, Product.fromJson(v)))));

String productToJson(List<Map<String, Product>> data) =>
    json.encode(List<dynamic>.from(data.map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class Product {
  Product(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      this.id});

  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  Product copy() => Product(
      available: available, name: name, picture: picture, price: price, id: id);
}
