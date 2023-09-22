import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/customs/dialoguebox.dart';
import 'package:todo_application/sign_in.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final emailcontroller = TextEditingController();
   bool circular = false;
   final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
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
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Column(
                        children: [
                          TextField(
                            controller: emailcontroller,
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
                                borderSide:
                                    const BorderSide(width: 1, color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                ),
                                onPressed: () async {
                                  setState(() {
                                    circular = true;
                                  });
                                  try {
                                    var email = emailcontroller.text;
                                   if(email.isEmpty){
                                     setState(() {
                                       circular = false;
                                     });
                                     showDialog(context: context, builder: (context){
                                       return dialogue2(title: "Please Enter A Valid Email", callback: (){
                                         Navigator.pop(context);
                                       });
                                     });
                                   }
                                   else{
                                     auth.sendPasswordResetEmail(email: emailcontroller.text);
                                     showDialog(context: context, builder: (context){
                                       return dialogue2(title: "Reset passwrod link has been sent \n Please check your email", callback: (){
                                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
                                       });
                                     });
                                     Timer(Duration(seconds: 20), () {  setState(() {
                                       circular = false;

                                     });});
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
                                    ? const CircularProgressIndicator(color: Colors.white,)
                                    : const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
