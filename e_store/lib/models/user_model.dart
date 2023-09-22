import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? image;
  String name;
  String email;
  String phone;
  String address;
  UserModel({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required  this.address,
    required this.phone
  } );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
        phone: json["phone"],
    address: json["address"]
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "image":image,
    "name": name,
    "email":email,
    "phone":phone,
    "address":address

  };
  UserModel copyWith({
   String? name,
   String? phone,
    String? address,
    image,
})=>UserModel(id: id, image: image?? this.image, name: name?? this.name, email: email, phone: phone?? this.phone, address: address?? this.address);
}