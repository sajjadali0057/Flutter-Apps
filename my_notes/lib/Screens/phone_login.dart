import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class phoneLogin extends StatefulWidget {
  const phoneLogin({super.key});

  @override
  State<phoneLogin> createState() => _phoneLoginState();
}

class _phoneLoginState extends State<phoneLogin> {
  @override
  String? otpcontroller = "";
  bool circle = false;
  bool buttoncircle = false;
  final numbercontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
String contactNumber= '';

  String verificationId= "";


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffBE5869), Color(0xff403A3E)])),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 70,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Enter Your Phone Number",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      controller: numbercontroller,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black38
                              )
                          ),
                          hintText: '311 1122334',
                          hintStyle: const TextStyle(color: Colors.white54),
                          suffixIcon: SizedBox(
                            height: 10.0,
                            width: 10.0,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    circle = true;
                                    contactNumber = ('+92${numbercontroller}');
                                  });

                                  Timer(const Duration(seconds: 60), () {
                                    circle = false;
                                    setState(() {});
                                  });

                                  try {
                                    if (numbercontroller == null) {
                                      SnackBar snackBar = const SnackBar(
                                          content: Text(
                                              'Please enter a valid phone number'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      auth.verifyPhoneNumber(
                                          phoneNumber: ("+92 ${numbercontroller.text}"),
                                          verificationCompleted: (_) {},
                                          verificationFailed: (e) {
                                            setState(() {
                                              circle = false;
                                            });
                                            SnackBar snackBar = SnackBar(
                                                content: Text(e.toString()));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          codeSent: (String verificationId,
                                              int? token) {

                                            SnackBar snackBar = const SnackBar(
                                                content:
                                                    Text('Code Has Been Sent'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          codeAutoRetrievalTimeout: (e) {
                                            setState(() {
                                              circle = false;
                                            });

                                          });
                                    }
                                  } catch (e) {}
                                },
                                child: SizedBox(
                                  height: 10.0,
                                  width: 10.0,
                                  child: circle
                                      ? const SizedBox(
                                          height: 10.0,
                                          width: 10.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.green,

                                          ),
                                        )
                                      : const Icon(
                                          Icons.send_rounded,
                                          color: Colors.green,
                                        ),
                                )),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8)),
                          focusColor: Colors.black26),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Enter Your Code Here",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: OTPTextField(
                      length: 6,
                      onCompleted: (value){
                        setState(() {
                          otpcontroller = value;
                        });

                      },

                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.black12,
                        borderColor: Colors.black,
                        focusBorderColor: Colors.black54,
                        errorBorderColor: Colors.red,
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      fieldWidth: 45,
                      spaceBetween: 5,
                      fieldStyle: FieldStyle.box,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black26,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () async {
                          setState(() {
                            buttoncircle = true;
                          });

                          final credential = PhoneAuthProvider.credential(
                              smsCode: otpcontroller!, verificationId: verificationId);
                          print("Code is $otpcontroller");
                          try {
                            await auth.signInWithCredential(credential);

                            setState(() {
                              buttoncircle = false;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const homeScreen()));
                            });
                          } catch (e) {
                            setState(() {
                              buttoncircle = false;
                            });
                            SnackBar snackBar = SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: buttoncircle
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Verify",
                                style: TextStyle(fontSize: 20),
                              )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
