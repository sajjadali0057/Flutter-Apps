import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:my_notes/Screens/signin_screen.dart';
import 'package:quickalert/quickalert.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final namectcl = TextEditingController();
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  final cnfrmpasswordctrl = TextEditingController();
  bool circular = false;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    circular = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
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
                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
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
                    //         'assets/svglogos/phone.svg',
                    //         width: 30,
                    //       ),
                    //       Text(
                    //         'Signup Via Phone',
                    //         style: TextStyle(fontSize: 17, color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Center(
                      child: Text(
                        'Just a few steps to sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                controller: namectcl,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    hintText: "Enter Your Name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black38,
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                controller: emailctrl,
                                decoration: InputDecoration(
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
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                controller: passwordctrl,
                                decoration: InputDecoration(
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
                              height: 10,
                            ),
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                controller: cnfrmpasswordctrl,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    hintText: "Confirm Your Password",
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.black38,
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
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
                              checkdata();
                            },
                            child: circular
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('Sign Up'))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signIn()));
                          },
                          child: Text(
                            "Login",
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

  void checkdata() {
    var fullname = namectcl.text;
    var email = emailctrl.text;
    var password = passwordctrl.text;
    var confirmpassword = cnfrmpasswordctrl.text;
    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty) {
      setState(() {
        circular = false;
      });
      SnackBar snackbar = SnackBar(content: Text('Please Fill All The Fields'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      if (password == confirmpassword) {
        signupauth();
      }
    }
  }

  void signupauth() async {
    try {
      if (_formkey.currentState!.validate()) {
        await auth.createUserWithEmailAndPassword(
            email: emailctrl.text.toString(),
            password: passwordctrl.text.toString());
        final currentuser = auth.currentUser!;
        currentuser.sendEmailVerification();
        final uid = currentuser?.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection("userinformation")
            .doc(uid)
            .set({'fullname': namectcl.text, 'email': emailctrl.text}).then(
                (value) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            confirmBtnColor: Colors.black54,
            onConfirmBtnTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => signIn()),
                  (route) => false);
            },
            title: 'Account Created',
            text: "Please check your email to verify account",
            barrierColor: Colors.black87,
          );
        }).onError((error, stackTrace) {
          SnackBar snackBar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } catch (e) {
      setState(() {
        circular = false;
      });
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
