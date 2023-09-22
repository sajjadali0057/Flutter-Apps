import 'package:e_store/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../constants/circularindicator.dart';
import '../../firebase_helper/firebasefirestore_helper/firebase_firestore_helper.dart';
import '../../models/orders_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel singleProduct;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Your Orders",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18,right: 18,bottom: 60),
        child: FutureBuilder(
            future: FirebaseFirestoreHelper.instance.getUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text("No order found"),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      child: showCircular(),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        OrderModel orderModel = snapshot.data![index];
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: showCircular());
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15,top: 10),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,

                            collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: Colors.deepOrange, width: 2)),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.deepOrange, width: 2)),
                            title: Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  child: Image.network(
                                      orderModel.products[0].image),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        orderModel.products[0].name,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Total Price: \$${orderModel.totalprice}",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                      orderModel.products.length > 1
                                          ? SizedBox.fromSize()
                                          : Text(
                                            "Quantity: ${orderModel.products[0].quantity}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold,
                                                height: 1.5),
                                          ),
                                      Text(
                                        "Order Status: ${orderModel.status}",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                      Text(
                                        "Payment: ${orderModel.payment}",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                      SizedBox(height: 20,),


                                    ],
                                  ),
                                )
                              ],
                            ),
                            children:
                              orderModel.products.length > 1 ?
                                [
                                  Text("Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54),),
                                  Divider(color: Colors.deepOrange,),

                                  ...orderModel.products.map((singleProduct) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                  child: Column(
                                    children: [
                                      const Divider(color: Colors.deepOrange,),
                                      Row(

                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            child: Image.network(
                                                singleProduct.image),
                                          ),
                                          SizedBox(width: 30,),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  singleProduct.name,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Price: \$${singleProduct.price}",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1.5),
                                                ),
                                                 Text(
                                                  "Quantity: ${singleProduct.quantity}",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      height: 1.5),
                                                ),
                                                Divider(color: Colors.deepOrange,)

                                              ],
                                            ),
                                          )
                                        ],
                                      ),


                                    ],
                                  ),

                                );
                                 }).toList()]:[]
                          )
                        );
                      });
                }
              }
            }),
      ),
    );
  }
}
