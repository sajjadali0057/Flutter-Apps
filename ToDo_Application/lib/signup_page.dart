import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/home_page.dart';
import 'package:todo_application/phone_auth_page.dart';
import 'package:todo_application/service/auth_service.dart';
import 'package:todo_application/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    var password = passwordController.text;
    var confirmpassword = confirmpasswordController.text;
    var fullname = fullnameController.text;
    var email = emailController.text;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.black87,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          await authClass.googleSignin(context);
                        },
                        child: Card(
                          elevation: 8,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 50, right: 50, bottom: 10),
                            child: SvgPicture.asset(
                              "assets/google.svg",
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const PhoneAuth()),
                              (route) => false);
                        },
                        child: Card(
                          elevation: 8,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                  width: 1, color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 50, right: 50, bottom: 10),
                            child: SvgPicture.asset(
                              "assets/telephone.svg",
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Or",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    // height: 60,
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: fullnameController,
                          decoration: InputDecoration(
                            label: const Text(
                              'Full Name',
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: emailController,
                          decoration: InputDecoration(
                            label: const Text(
                              'Email',
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            label: const Text(
                              'Password',
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: confirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            label: const Text(
                              'Confirm Password',
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                setState(() {
                                  circular = true;
                                });
                                try {
                                  if (fullname.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty ||
                                      confirmpassword.isEmpty) {
                                    final snackbar = SnackBar(
                                        content: Text(
                                            'Please enter all the details'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                    setState(() {
                                      circular = false;
                                    });
                                  } else {
                                    if (password != confirmpassword) {
                                      final snackbar = SnackBar(
                                          content:
                                              Text('Password do not match'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar((snackbar));
                                      setState(() {
                                        circular = false;
                                      });
                                    } else {
                                      firebase_auth.UserCredential
                                          userCredential = await firebaseAuth
                                              .createUserWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                      final auth = FirebaseAuth.instance;
                                     final currentUser = firebaseAuth.currentUser;
                                     currentUser?.sendEmailVerification();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => HomePage()),
                                          (route) => false);
                                      setState(() {
                                        circular = false;
                                      });
                                    }
                                  }
                                } catch (e) {
                                  setState(() {
                                    circular = false;
                                  });
                                  final snackBar =
                                      SnackBar(content: Text(e.toString()));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: circular
                                  ? const CircularProgressIndicator()
                                  : const Text('Sign Up',
                                      style: TextStyle(fontSize: 17))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ? ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
