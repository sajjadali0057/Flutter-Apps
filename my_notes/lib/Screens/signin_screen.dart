import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:my_notes/Screens/signup_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'forgot_password.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  bool circular = false;
  bool verified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    circular = false;
    emailctrl.clear();
    passwordctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffBE5869), Color(0xff403A3E)])),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     color: Colors.black26,
                    //   ),
                    //   height: 60,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       SvgPicture.asset(
                    //         'assets/svglogos/google.svg',
                    //         width: 30,
                    //       ),
                    //       Text(
                    //         'Signup Via Google',
                    //         style: TextStyle(fontSize: 17, color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => phoneLogin()));
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: Colors.black26,
                    //     ),
                    //     height: 60,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         SvgPicture.asset(
                    //           'assets/svglogos/phone.svg',
                    //           width: 30,
                    //         ),
                    //         Text(
                    //           'Signup Via Phone',
                    //           style:
                    //               TextStyle(fontSize: 17, color: Colors.white),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    const Center(
                      child: Text(
                        'Welcome back',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: emailctrl,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            hintText: "Enter Your Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black38,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: passwordctrl,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            hintText: "Enter Your Password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black38,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const forgotPassword()));
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black26),
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              setState(() {
                                circular = true;
                              });
                              auth.signInWithEmailAndPassword(
                                  email: emailctrl.text.toString(),
                                  password: passwordctrl.text.toString());
                              signinauth();
                            },
                            child: circular
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Sign In'))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => const signUp()),
                                (route) => false);
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void signinauth() {
    var email = emailctrl.text;
    var password = passwordctrl.text;
    if (email.isEmpty || password.isEmpty) {
      SnackBar snackBar =
          const SnackBar(content: Text('Please Enter Email And Password'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        circular = false;
      });
    } else {
      try {
        final user = auth.currentUser;
        if (user!.emailVerified) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => homeScreen()));
        }
        else
        {
          QuickAlert.show(context: context, type: QuickAlertType.error,
              title: "Verification Error",
              text: "Please check your email to verify your account",
              confirmBtnColor: Colors.black54);
          setState(() {
            circular = false;
          });
        }
      } catch (e) {
        setState(() {
          circular = false;
          signinauth();
        });
        SnackBar snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
