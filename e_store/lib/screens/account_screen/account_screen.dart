import 'package:e_store/constants/dialogue.dart';
import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/firebase_helper/firebse_auth_helper/firebase_auth_helper.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/account_screen/edit_Information.dart';
import 'package:e_store/screens/change_password/change_password.dart';
import 'package:e_store/screens/favourite_screen/favourite_screen.dart';
import 'package:e_store/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/circularindicator.dart';
import '../orders_screen/order_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bool loading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange.withOpacity(0.3),
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance
                    .Push(context: context, widget: const EditUserInformation());
              },
              icon: const Icon(
                Icons.edit_outlined,
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: loading
          ? const Center(
              child: showCircular(),
            )
          : Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: Colors.deepOrange.withOpacity(0.3),
                    child: Column(
                  children: [
                    appProvider.getUserInfo.image == null
                        ? const Icon(
                            Icons.person_outline,
                            size: 150,
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(appProvider.getUserInfo.image!)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(appProvider.getUserInfo.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(appProvider.getUserInfo.email,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black54)),
                  ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, bottom: 75),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 60,),
                            AccountListTile(
                              icon: Icons.shopping_bag_outlined,
                              title: "Your Orders",
                              ontap: () {
                                Routes.instance.Push(context: context, widget: const OrdersScreen());
                              },
                            ),
                            AccountListTile(
                                icon: Icons.favorite_border_outlined,
                                title: "Favorites",
                                ontap: () {
                                  Routes.instance.Push(
                                      context: context,
                                      widget: const FavouriteScreen());
                                }),
                            AccountListTile(
                                icon: Icons.info_outline,
                                title: "About Us",
                                ontap: () {}),
                            AccountListTile(
                                icon: Icons.support_outlined,
                                title: "Support",
                                ontap: () {}),
                            AccountListTile(
                                icon: Icons.change_circle_outlined,
                                title: "Change Password",
                                ontap: () {Routes.instance.Push(context: context, widget: const ChangePassword());}),
                            AccountListTile(
                                icon: Icons.logout_outlined,
                                title: "Logout",
                                ontap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialogue(
                                            title: "Logout",
                                            callback: () {
                                              try {
                                                firebase_auth_helper().logout();
                                                setState(() {
                                                  Routes.instance
                                                      .PushandRemoveUntil(
                                                          context: context,
                                                          widget:
                                                              const welcome_page());
                                                });
                                              } catch (e) {
                                                showToast(e.toString());
                                              }

                                              // Routes.instance.PushandRemoveUntil(context: context, widget: welcome_page());
                                            },
                                            no: () {
                                              Navigator.pop(context);
                                            });
                                      });
                                  // Routes.instance.PushandRemoveUntil(context: context, widget: welcome_page());
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Version 1.0.0")
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  void Function()? ontap;

  AccountListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        size: 25,
        color: Colors.black.withOpacity(0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7)),
      ),
    );
  }
}
