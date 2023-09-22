
import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/constants/validation.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/screens/login/login.dart';
import 'package:e_store/screens/welcome/welcome.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:e_store/widgets/titles/welcome_titles.dart';
import 'package:flutter/material.dart';

import '../../widgets/fields.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    final emailcontroller = TextEditingController();
    final namecontroller = TextEditingController();
    final passwordcontroller = TextEditingController();
    final confirmpasswordcontroller = TextEditingController();
    final phonecontroller = TextEditingController();
    final addresscontroller = TextEditingController();
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        const SizedBox(height: kToolbarHeight+22,),
        Titles(title: "Create Account", subtitle: "Create An Account"),
        const SizedBox(height: 30,),
        namefield(hint: "Name", icon: Icons.person, controller: namecontroller, type: TextInputType.text, ),
        const SizedBox(height: 15,),
        namefield(hint: "03123456789", icon: Icons.phone, controller: phonecontroller, type: TextInputType.phone,),
        const SizedBox(height: 15,),
        emailField(emailhint: 'Email',controller: emailcontroller,),
        const SizedBox(height: 15,),
        passwordField(hint: 'Password', controller: passwordcontroller,),
        const SizedBox(height: 15,),
        passwordField(hint: 'Confirm Password', controller: confirmpasswordcontroller,),
        const SizedBox(height: 30,),
        PrimaryButton(onPressed: () async{
          try{
            bool isValidated = signUpvalidation(emailcontroller.text, passwordcontroller.text, namecontroller.text,
                phonecontroller.text, confirmpasswordcontroller.text,addresscontroller.text);
            if(isValidated)
              {
                firebase_auth_helper().signup(emailcontroller.text, passwordcontroller.text,namecontroller.text,phonecontroller.text,addresscontroller.text);
                 Routes().PushandRemoveUntil(context: context, widget: const LoginScreen());

              }


          }
          catch(e){
            showToast("$e");
          }
        }, name: "Sign Up"),
        const SizedBox(height: 30,),
        const Center(child: Text("Already have an account?")),
        const SizedBox(height: 10,),
        Center(
          child: InkWell(
            onTap: (){
              Routes().PushandRemoveUntil(context: context, widget: const welcome_page());
            },
            child: Text("Login", style: TextStyle(
              color: Theme.of(context).primaryColor
            ),),
          ),
        )
      ],
    ))));
  }
}
