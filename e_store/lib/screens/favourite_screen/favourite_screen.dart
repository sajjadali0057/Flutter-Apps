import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/widgets/single_favourite_product/single_favourite_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../widgets/cart_single_product/cart_single_product.dart';
import '../../widgets/elevatedbutton/primary_button.dart';
import '../cart_screen/cart_screen.dart';
import '../home/home_page.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
         title:  Text(
           "Favorites",
           style: TextStyle(
               fontSize: 24,
               color: Colors.black,
               fontWeight: FontWeight.bold),
           textAlign: TextAlign.center,
         ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(8),
        //       child: BottomNavigationBar(
        //         elevation: 4,
        //         showSelectedLabels: false,
        //         showUnselectedLabels: false,
        //         items: <BottomNavigationBarItem>[
        //           BottomNavigationBarItem(
        //               icon: InkWell(
        //                 onTap: () {
        //                   Routes.instance
        //                       .Push(context: context, widget: homePage());
        //                 },
        //                 child: Icon(
        //                   Icons.home,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               label: ""),
        //           BottomNavigationBarItem(
        //               icon: InkWell(
        //                   onTap: () {
        //                     Routes.instance
        //                         .Push(context: context, widget: CartScreen());
        //                   },
        //                   child: Icon(Icons.shopping_cart)),
        //               label: ""),
        //           BottomNavigationBarItem(
        //               icon: InkWell(
        //                   onTap: () {
        //                     // Routes.instance
        //                     //     .Push(context: context, widget: widget);
        //                   },
        //                   child: Icon(Icons.person)),
        //               label: "")
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 250,
                  child: appProvider.GetFavoutireList.isEmpty
                      ? Center(
                      child: Text(
                        "Wishlist is Empty",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ))
                      : ListView.builder(
                      itemCount: appProvider.GetFavoutireList.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SingleFavouriteProduct(
                            singleProduct:
                            appProvider.GetFavoutireList[index]);
                      }),
                ),
              ],
            )));
  }
}
