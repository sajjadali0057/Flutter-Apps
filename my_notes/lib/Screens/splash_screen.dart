import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:my_notes/Screens/signin_screen.dart';
import 'package:my_notes/Screens/signup_screen.dart';
import 'package:quickalert/quickalert.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      setState(() {
        checklogin();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xffBE5869), Color(0xff403A3E)]),
      ),
      child: Center(
          child: Container(
              width: 300,
              // child: SvgPicture.asset('assets/logo.svg'))),
              child: Image.asset('assets/images/logo.png'))),
    );
  }

  void checklogin() {
    final auth = FirebaseAuth.instance;
    final currentuser = auth.currentUser;
    if (currentuser != null) {
      if (currentuser.emailVerified) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homeScreen()));
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Verification Error",
            text: "Please check your email to verify your account",
            onConfirmBtnTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => signIn()),
                  (route) => false);
            },
            confirmBtnColor: Colors.black54);
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => signIn()));
    }
  }
}
