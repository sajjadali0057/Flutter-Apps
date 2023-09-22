import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/texts.dart';
import 'package:e_store/screens/login/login.dart';
import 'package:e_store/screens/signup/signup.dart';
import 'package:e_store/widgets/titles/welcome_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_store/constants/asset_images.dart';
import '../../constants/asset_icons.dart';
import '../../widgets/elevatedbutton/primary_button.dart';
class welcome_page extends StatelessWidget {
  const welcome_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight+ 22,
            ),
            Titles(title: title, subtitle: subtitle,),
            const SizedBox(height: 10,),
            Image.asset(AssetsImages.instance.welcomeimage),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(child: Image.asset(AssetsIcons.instance.googleicon,scale: 12,),
                    onPressed: (){},
                ),
                const SizedBox(width: 10,),
                CupertinoButton(child: Image.asset(AssetsIcons.instance.facebookicon,scale: 12,),
                  onPressed: (){},

                ),
              ],

            ),
            const SizedBox(height: 20,),
            PrimaryButton(onPressed: () {
              Routes().Push(widget: const LoginScreen(), context: context);
            }, name: 'Login',),
            const SizedBox(height: 10),
            const SizedBox(height: 12,),
            PrimaryButton( onPressed: (){
              Routes().Push(context: context, widget: const signUp());
            },name: "Sign Up",)
          ],
        ),
      ),
    );
  }
}


