
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/home_page.dart';
import 'package:todo_application/service/auth_service.dart';
import 'package:todo_application/sign_in.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}): super(key : key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void checkLogin() async{
    final auth =FirebaseAuth.instance;
    final currentuser = auth.currentUser;
    // if (currentuser!=null)
    //   {
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    //   }
    // else {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
    // }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
  @override
  initState() {
    super.initState();
    checkLogin();
    Timer( Duration(milliseconds: 5000), () {
     return checkLogin();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset("assets/splash.png")
      ),
    );
  }

}
