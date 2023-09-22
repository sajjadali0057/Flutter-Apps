import 'package:e_store/constants/circularindicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showLoader extends StatefulWidget {
  showLoader({super.key});
  @override
  State<showLoader> createState() => _showLoaderState();
}

class _showLoaderState extends State<showLoader> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      title: Center(
        child: SizedBox(
          width: 200,
         child: showCircular(),
        ),
      ),
    );

  }
}

