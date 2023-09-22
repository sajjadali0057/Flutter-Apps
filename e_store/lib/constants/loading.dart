import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class loading {
  showLoading(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Builder(builder: (context) {
        return Container(
          color: Colors.transparent,
          height: 100,
          child: Center(
            child: Container(
              color: Colors.transparent,
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          ),
        );
      }),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
