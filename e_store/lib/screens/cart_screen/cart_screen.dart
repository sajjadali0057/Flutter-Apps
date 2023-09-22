import 'package:e_store/constants/splash.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:e_store/screens/checkout_screen/checkout_screen.dart';
import 'package:e_store/widgets/cart_single_product/cart_single_product.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../home/home_page.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Text(
            "Cart",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

        ),
        bottomNavigationBar: SizedBox(
          height: 170,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${appProvider.totalPrice().toString()}",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                PrimaryButton(onPressed: (){
                  appProvider.clearCheckoutProducts();
                  appProvider.addCheckoutCartProductsList();

                  if(appProvider.getCheckoutProductsList.isEmpty){
                    showToast("Cart is empty");
                  }
                  else{
                    Routes.instance.Push(context: context, widget: CartItemCheckout());
                  }

                }, name:"CheckOut"),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: appProvider.GetCartProductList.isEmpty
                        ? Center(
                            child: Text(
                            "Cart is Empty",
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                          ))
                        : ListView.builder(
                            itemCount: appProvider.GetCartProductList.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CartSingleProduct(
                                  singleProduct:
                                      appProvider.GetCartProductList[index]);
                            }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                
              ],
            )));
  }
}
