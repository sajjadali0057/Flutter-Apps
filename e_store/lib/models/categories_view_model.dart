import 'dart:convert';
CategoryViewModel categoryViewModelFromJson(String str) => CategoryViewModel.fromJson(json.decode(str));
String categoryViewModelToJson(CategoryViewModel data) => json.encode(data.toJson());
class CategoryViewModel {
  String id;
  String name;
  String image;
  double price;
  String description;
  String status;
  bool isFavourite;
  CategoryViewModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.status,
    required this.isFavourite,
  });
  factory CategoryViewModel.fromJson(Map<String, dynamic> json) => CategoryViewModel(
      id: json["id"],
      name: json["name"],
      price:double.parse(json["price"].toString()) ,
      description: json["description"],
      image: json["image"],
      status: json["status"],
      isFavourite: false
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price":price,
    "description":description,
    "status":status,
    "isFavourite":isFavourite,
    "image":image
  };
}