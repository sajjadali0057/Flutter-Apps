import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Screens/signin_screen.dart';
import 'package:quickalert/quickalert.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  bool circular = false;
  final emailcontroller = TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: emailcontroller,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            hintText: "Enter Your Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black38,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
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
                              var email = emailcontroller.text;
                              if (email.isEmpty) {
                                SnackBar snackBar =
                                SnackBar(content: Text(
                                    'Please enter a valid email'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  circular = false;
                                });
                              }
                              else {
                                try {
                                  final auth = FirebaseAuth.instance;
                                  auth.sendPasswordResetEmail(
                                      email: emailcontroller.text.toString());
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.info,
                                    confirmBtnColor: Colors.black54,
                                    onConfirmBtnTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => signIn()),
                                              (route) => false);
                                    },
                                    title: 'Email Sent',
                                    text:
                                    "Password reset email has been sent! please check your email",
                                    barrierColor: Colors.black87,
                                  );
                                  setState(() {
                                    circular = false;
                                  });
                                } catch (e) {
                                  SnackBar snackBar =
                                  SnackBar(content: Text(e.toString()));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }

                            },
                            child: circular
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Reset'))),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
