
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/firebase_helper/firebasefirestore_helper/firebase_firestore_helper.dart';
import 'package:e_store/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:e_store/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

// Cart Functionality
class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];
  final List <ProductModel>_buyProduct=[];

  UserModel? _userModel;

  UserModel get getUserInfo => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get GetCartProductList => _cartProductList;

  // Favourite Functionality

  final List<ProductModel> _favoutireList = [];

  void addFavourite(ProductModel productModel) {
    _favoutireList.add(productModel);
    notifyListeners();
  }

  void removeFavourite(ProductModel productModel) {
    _favoutireList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get GetFavoutireList => _favoutireList;

//USer Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInfo();
    notifyListeners();
  }

  void updateUserInfo(BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showCircular;
           await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.id)
          .update(userModel.toJson());
     notifyListeners();
     showToast("Updated Successfully");
     Navigator.of(context).pop();
    }
    else{
      String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.id)
          .update(userModel.toJson());
      notifyListeners();
      showToast("Updated Successfully");

    }
  }
  /////// Total Price

double totalPrice(){
    double totalPrice = 0.0;
    for (var element in _cartProductList){
      totalPrice+=element.price*element.quantity!;

    }
    return totalPrice;
}
void updateQuantity(ProductModel productModel, int qty)async{
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].quantity=qty;
    notifyListeners();
}
// Checkout
  void addCheckoutProducts(ProductModel model){
    _buyProduct.add(model);
    notifyListeners();
  }
  void addCheckoutCartProductsList(){
    _buyProduct.addAll(_cartProductList);
    notifyListeners();
  }
  void clearCart(){
    _cartProductList.clear();
    notifyListeners();
  }
  void clearCheckoutProducts(){
    _buyProduct.clear();
    notifyListeners();
  }
List<ProductModel> get getCheckoutProductsList => _buyProduct;

}
