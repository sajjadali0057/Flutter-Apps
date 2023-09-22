import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/loading.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/models/product_model.dart';
import 'package:e_store/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../constants/showLoading.dart';
import '../../constants/toast.dart';
import '../../models/categories_view_model.dart';
import '../../models/category_model.dart';
import '../../models/orders_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getTopSelling() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();
      List<ProductModel> topSellingList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return topSellingList;
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }

  Future<List<CategoryViewModel>> getCategoryView(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();
      List<CategoryViewModel> categoryViewList = querySnapshot.docs
          .map((e) => CategoryViewModel.fromJson(e.data()))
          .toList();
      if (categoryViewList.isEmpty) {
        showToast("Empty");
        return [];
      } else {
        return categoryViewList;
      }
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInfo() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderProductsFirebase(
      List<ProductModel> list, String payment) async {
    try {
      double totalPrice = 0;
      for (var element in list) {
        totalPrice += element.price * element.quantity!;
      }
      String orderid = DateTime.now().millisecondsSinceEpoch.toString();
      DocumentReference documentReference = await _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("orders").doc();
      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalprice": totalPrice,
        "payment": payment,
        "orderid": admin.id
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalprice": totalPrice,
        "payment": payment,
        "orderid": documentReference.id
      });
      return true;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }
  //Get Orders for users
  Future<List<OrderModel>> getUserOrders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("usersOrders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orders")
              .get();
      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();
      return orderList;
    } catch (e) {
      showToast(e.toString());
      return [];
    }
  }
  void updateTokenFromFirebase()async {
    String? token = await FirebaseMessaging.instance.getToken();
    if(token !=null){
     await _firebaseFirestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
          {"notificationtoken":token});
    }
  }
}
