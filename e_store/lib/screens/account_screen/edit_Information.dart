import 'dart:io';
import 'dart:math';

import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:e_store/models/user_model.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/account_screen/account_screen.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:e_store/widgets/fields.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../constants/routes.dart';

class EditUserInformation extends StatefulWidget {
  const EditUserInformation({super.key});

  @override
  State<EditUserInformation> createState() => _EditUserInformationState();
}

class _EditUserInformationState extends State<EditUserInformation> {
  bool istrue = false;

  File? image;
  String imagepath = "";
  bool loading = false;

  Future<bool> pickImage() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(
            () {
          image = File(value.path);
        },
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
setState(() {

});
    late TextEditingController namecontroller;
    namecontroller = TextEditingController(text: appProvider.getUserInfo.name.toString());
    late TextEditingController phonecontroller;
    phonecontroller = TextEditingController(text: appProvider.getUserInfo.phone.toString());
    late TextEditingController addresscontroller;
    addresscontroller = TextEditingController(text: appProvider.getUserInfo.address.toString());
    return SafeArea(
      child:loading? Container(color: Colors.white,child: Center(child: showCircular(),),) :Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text("Account Information", style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
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
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 75),
              child: Container(
                  child: Column(
                    children: [
                      appProvider.getUserInfo.image == null
                          ? InkWell(
                        onTap: () async {
                          try {
                            bool isDone = await pickImage();
                            if (isDone) {
                              FirebaseStorageHelper.instance
                                  .uploadUserImage(image!);
                            } else {
                              showToast("Uploading not successful");
                            }
                          } catch (e) {
                            "Error";
                          }
                        },
                        child: CircleAvatar(
                          
                          radius: 70,
                          backgroundColor: Colors.deepOrange.withOpacity(0.3),
                          child: Icon(Icons.camera_alt_outlined,size: 50,color: Colors.white,),
                        ),
                      )
                          : InkWell(
                        onTap: () async {
                          try {
                            bool isDone = await pickImage();
                            if (isDone) {
                              FirebaseStorageHelper.instance
                                  .uploadUserImage(image!);
                            } else {
                              showToast("Uploading not successful");
                            }
                          } catch (e) {
                            "Error";
                          }
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(appProvider.getUserInfo.image!),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      namefield(
                          hint: "",
                          icon: Icons.person_outline,
                          controller: namecontroller,
                          type: TextInputType.text),
                      SizedBox(
                        height: 30,
                      ),
                      namefield(
                          hint: "",
                          icon: Icons.phone_android_outlined,
                          controller: phonecontroller,
                          type: TextInputType.number),
                      SizedBox(
                        height: 30,
                      ),
                      namefield(
                          hint:"",
                          icon: Icons.add_location_alt_outlined,
                          controller: addresscontroller,
                          type: TextInputType.text),
                      SizedBox(height: 30,),
                      PrimaryButton(onPressed: () {
                        setState(() {
                          loading= true;
                        });
                        UserModel userModel = appProvider.getUserInfo.copyWith(
                            name: namecontroller.text,
                            phone: phonecontroller.text,
                        address: addresscontroller.text);
                        appProvider.updateUserInfo(
                            context,
                            userModel,image);
                        setState(() {
                          Routes.instance.PushandRemoveUntil(context: context, widget: AccountScreen());
                          loading = false;
                        });
                      }, name: 'Update',)
                    ],
                  ))),
        ),
      ),
    );
  }
}
