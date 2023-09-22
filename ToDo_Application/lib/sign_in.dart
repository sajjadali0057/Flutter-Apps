import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_application/customs/dialoguebox.dart';
import 'package:todo_application/home_page.dart';
import 'package:todo_application/service/forgotpassword_page.dart';
import 'package:todo_application/signup_page.dart';
import 'package:todo_application/service/auth_service.dart';
import 'phone_auth_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}): super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool circular = false;
  AuthClass authClass = AuthClass();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.black87,
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        elevation: 8,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(width: 1, color: Colors.white),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await authClass.googleSignin(context);

                          },
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
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (builder) => const PhoneAuth()), (
                                  route) => false);
                        },
                        child: Card(
                          elevation: 8,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(width: 1,
                                  color: Colors.white)),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 60,
                    // height: 60,
                    child: Column(
                      children: [
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                              ),
                              onPressed: () async {
                                setState(() {
                                  circular = true;
                                });
                                try {
                                  firebase_auth.UserCredential userCredentials =
                                  await firebaseAuth
                                      .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password:
                                      passwordController.text);
                                  authClass.storeTokenAndData(userCredentials);
                                  final auth = FirebaseAuth.instance;
                                  final currentUser = auth.currentUser;


                                  if(
                                  currentUser!.emailVerified
                                  )
                                    {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  builder) => HomePage()),
                                              (route) => false);
                                      setState(() {
                                        circular = false;
                                      });
                                    }
                                  else {
                                    showDialog(context: context, builder: (context){
                                      return dialogue2(title: 'Please verify your email', callback: (){
                                        Navigator.pop(context);
                                      },);
                                    });
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
                                  : const Text(
                                'Sign In',
                                style: TextStyle(fontSize: 17),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account ?  ",
                              style:
                              TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => const Signup()),
                                        (route) => false);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                         InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpassword()));
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
