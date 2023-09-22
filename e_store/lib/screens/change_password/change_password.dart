import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/loading.dart';
import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/constants/validation.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:e_store/widgets/fields.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordcontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Container(
        color:Colors.white,child: Center(child: showCircular())):Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text("Change Password", style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,

          ),
          textAlign: TextAlign.start,),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                )),
            SizedBox(
              width: 20,
            )
          ],
        ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 75),child:Column(
        children: [
          SizedBox(
                    height: 30,
                  ),
                  passwordField(
              hint: "New Password", controller: newpasswordcontroller),
          SizedBox(height: 30,),
          passwordField(
              hint: "Confirm Password", controller: confirmpasswordcontroller),
          SizedBox(height: 30,),
          PrimaryButton(
              onPressed: ()async {

                try {
                  setState(() {
                    loading = true;
                  });
                  bool validate = passwordChangevalidation(
                      newpasswordcontroller.text,
                      confirmpasswordcontroller.text);
                  if (validate) {
                    await firebase_auth_helper().changePassword(context,
                      newpasswordcontroller.text,
                    );

                  }


                }
                    catch(e){
                  loading = false;
                  showToast(e.toString());
                    }
              },
              name: "Change Password")
        ],
      ),
    )));
  }
}

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({super.key});

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
