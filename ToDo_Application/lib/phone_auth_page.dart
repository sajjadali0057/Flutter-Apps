import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo_application/service/auth_service.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}): super(key : key);

  @override
  State<PhoneAuth> createState() => PhoneAuthState();
}

class PhoneAuthState extends State<PhoneAuth> {

  int start = 30;
  bool wait = false;
  final phoneController = TextEditingController();
  String buttonname = "Send";
  AuthClass authClass = AuthClass();
  String veficationIDfinal = '';
  String smsCode = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.black87),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)),
                  height: 60,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your phone number",

                          contentPadding:
                          const EdgeInsets.symmetric(
                              vertical: 19, horizontal: 8),
                          hintStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.white54,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              '(+92)',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: InkWell(
                              onTap: wait ? null : () async {
                                startTimer();
                                setState(() {
                                  wait = true;
                                  buttonname = 'Resend';
                                  start = 30;
                                }
                                );
                                await authClass.verifyPhoneNumber(
                                    "+92 ${phoneController.text}", context,
                                    setData);
                              },
                              child: Text(
                                buttonname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: wait ? Colors.deepOrange : Colors
                                        .white),
                              ),
                            ),
                          ))),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 50,
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        height: 1, color: Colors.grey.shade800,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      )),
                      const Text('Enter 6 Digit OTP', style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),),
                      Expanded(child: Container(
                          height: 1, color: Colors.grey.shade800,
                          margin: const EdgeInsets.symmetric(horizontal: 10)))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                OTPTextField(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 30,
                  length: 6,
fieldWidth: 50,
                  otpFieldStyle: OtpFieldStyle(
                      backgroundColor: Colors.grey.shade800,
                      borderColor: Colors.white,
                      focusBorderColor: Colors.black87),
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print('Completed+$pin');
                    setState(() {
                      smsCode = pin;
                    });
                  },
                ),
                const SizedBox(height: 30,),
                RichText(text: TextSpan(children: [
                  const TextSpan(text: "Send OTP again  ",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                  TextSpan(text: "00:$start",
                      style: const TextStyle(
                          fontSize: 17, color: Colors.deepOrange)),
                ])),
                const SizedBox(height: 120,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: () {
                      authClass.signInWithPhoneNumber(
                          veficationIDfinal, smsCode, context);
                    },
                    child: const Text("Let's Go", style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),),),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        timer.cancel();

        wait = false;
      }
      else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(verificationId,
  ) {
    setState(() {
      veficationIDfinal = verificationId;
      ;
    });
    startTimer();
  }
}
