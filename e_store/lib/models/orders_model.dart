
import 'package:e_store/models/product_model.dart';
class OrderModel {
  String orderid;
  String payment;
  double totalprice;
  List<ProductModel> products;
  String status;

  OrderModel({
    required this.orderid,
    required this.payment,
    required this.totalprice,
    required this.status,
    required this.products
  } );
  factory OrderModel.fromJson(Map<String, dynamic> json){
    List<dynamic>productMap=json["products"];
return OrderModel(
    orderid: json["orderid"],
    payment: json["payment"],
    status: json["status"],
    totalprice: json["totalprice"],
    products: productMap.map((e) => ProductModel.fromJson(e)).toList());
  }
}