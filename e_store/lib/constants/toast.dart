import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void showToast(String message){
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange.shade100,
      textColor: Colors.deepOrange,
      fontSize: 16.0
  );
}