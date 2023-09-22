import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/texts.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/constants/validation.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_store/screens/forgot_password/forgot_password.dart';
import 'package:e_store/screens/home/home_page.dart';
import 'package:e_store/screens/signup/signup.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:e_store/widgets/titles/welcome_titles.dart';
import 'package:flutter/material.dart';

import '../../widgets/fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool show = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight + 22,
              ),
              Titles(title: logintitle, subtitle: loginsubtitle),
              SizedBox(
                height: 30,
              ),
              emailField(
                emailhint: 'Email',
                controller: emailcontroller,
              ),
              SizedBox(
                height: 15,
              ),
              passwordField(
                hint: 'Password',
                controller: passwordcontroller,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Routes().Push(context: context, widget: forgotPassword());
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              PrimaryButton(
                onPressed: () async {

                  bool isValidated = signInvalidation(
                      emailcontroller.text, passwordcontroller.text);
                  if (isValidated) {
                    bool? isLoggedin = await firebase_auth_helper()
                        .signin(emailcontroller.text, passwordcontroller.text);
                    if (isLoggedin != null) {
                      bool? isVarified =
                          await firebase_auth_helper().varified();
                      if (isVarified != null) {
                        Routes().PushandRemoveUntil(
                            context: context, widget: CustomBottomBar());
                      } else {
                        showToast("Please Varify Your Email");
                      }
                    }
                  }
                },
                name: 'Login',
              ),
              SizedBox(
                height: 30,
              ),
              Center(child: Text("Don't have an account?")),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: InkWell(
                focusColor: Colors.deepOrange,
                highlightColor: Colors.transparent,
                onTap: () {
                  Routes().Push(context: context, widget: signUp());
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
