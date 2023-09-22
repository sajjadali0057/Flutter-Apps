import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  String image;
  double price;
  String description;

  bool isFavourite;
  int? quantity;

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.description,

      required this.isFavourite,
      required this.quantity});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      price: double.parse(json["price"].toString()),
      description: json["description"],
      image: json["image"],

      isFavourite: false,
      quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,

        "isFavourite": isFavourite,
        "image": image,
        "quantity": quantity
      };
  ProductModel copyWith({
     int? quantity,
  }) =>
      ProductModel(
          id: id,
          image: image,
          name: name,
          price: price,
          description: description,

          isFavourite: isFavourite,
          quantity: quantity?? this.quantity);
}
