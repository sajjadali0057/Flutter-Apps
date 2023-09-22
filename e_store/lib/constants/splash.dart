import 'dart:async';

import 'package:e_store/constants/routes.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../screens/welcome/welcome.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  void check() async{
    bool validate = await firebase_auth_helper().checkLogin() as bool;
    if(validate){
     await Routes().PushReplacement(widget: const CustomBottomBar(), context: context);
    }
    else {
     await Routes().PushReplacement(widget: const welcome_page(), context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      check();
    });
    // check();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(

        child: Image.asset("assets/assetimages/splash.png",scale: 10,),
      ),
    );
  }
}
