import 'package:e_store/constants/texts.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';
class Titles extends StatelessWidget {

  String title ;
  String subtitle;
  Titles({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title == "Login" || title == "Create Account" || title == "Forgot Password")
          InkWell(
            onTap: (){
Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, size: 25,),
          ),
        SizedBox(height: 15,),
        Text(title,style: TextStyle(
          fontSize: 25,fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 10,),
        Text(subtitle, style: TextStyle(fontSize: 20, ),)
      ],
    );
  }
}
