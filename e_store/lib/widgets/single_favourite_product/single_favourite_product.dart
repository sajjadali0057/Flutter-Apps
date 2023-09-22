import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/toast.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';
class SingleFavouriteProduct extends StatefulWidget {
  ProductModel singleProduct;
   SingleFavouriteProduct({super.key,  required this.singleProduct});
  @override
  State<SingleFavouriteProduct> createState() => _SingleFavouriteProductState();
}
class _SingleFavouriteProductState extends State<SingleFavouriteProduct> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    int quantity = 1;
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.deepOrange, width: 2.5
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colors.red.withOpacity(0.3),
              child: Image.network(widget.singleProduct.image),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.singleProduct.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(widget.singleProduct.price.toString() + "\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                      onTap: (){
                        appProvider.removeFavourite(widget.singleProduct);
                      },
                      child: Text(
                        "Remove From Wishlist", style: TextStyle(color: Colors.deepOrange,fontSize: 15),)),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
