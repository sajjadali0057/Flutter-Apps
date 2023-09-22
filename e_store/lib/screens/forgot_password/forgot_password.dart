import 'dart:async';

import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/fields.dart';
import '../../widgets/titles/welcome_titles.dart';

class forgotPassword extends StatefulWidget {
   forgotPassword({super.key});
  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}
class _forgotPasswordState extends State<forgotPassword> {
TextEditingController emailcontroller = TextEditingController();
bool circular= false ;
Timer timer(){
 return Timer(Duration(seconds: 30), () {
   setState(() {
     circular = false;
   });
 });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
    children: [

    SizedBox(height: kToolbarHeight+22,),
    Titles(title: "Forgot Password", subtitle: "Please enter your email to send reset link"),
    SizedBox(height: 30,),
    emailField(emailhint: 'Email', controller: emailcontroller,),
    SizedBox(height: 15,),
      Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(6)),
        child: circular ? Center(child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,))): PrimaryButton(onPressed: () {
         final validate =  firebase_auth_helper().resetPassword(emailcontroller.text);
         if(
         validate!=null
         )
           {
             setState(() {
               circular = true;
             });
             timer();
           }

        }, name: 'Send',),
      ),
      SizedBox(height: 20,),
      circular ? Container(child: Center(child: Text("Retry in 30 seconds", style: TextStyle(fontSize: 16, ),)),): Container()
    ]))));
  }
}
