import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  void Function()? onPressed;
  String name = "";
   PrimaryButton({
    super.key,
     required this.onPressed,
     required this.name
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:50,
         width:double.infinity ,
         child: ElevatedButton(onPressed: onPressed, child: Text(name)));
  }
}