import 'package:e_store/constants/toast.dart';
import 'package:e_store/models/product_model.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSingleProduct extends StatefulWidget {
  CartSingleProduct({
    super.key,
    required this.singleProduct,
  });

  ProductModel singleProduct;



  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  int quantity= 1;
  void initState() {
    // TODO: implement initState
    super.initState();
     quantity = widget.singleProduct.quantity ?? 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepOrange, width: 2.5)),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.singleProduct.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.singleProduct.price.toString() + "\$",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                              appProvider.updateQuantity(widget.singleProduct, quantity);
                            }
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                           quantity++;
                           appProvider.updateQuantity(widget.singleProduct, quantity);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          if(appProvider.GetFavoutireList.contains(widget.singleProduct)){
                            appProvider.removeFavourite(widget.singleProduct);
                            showToast("Removed from wishlist");
                          }
                          else
                          {
                            appProvider.addFavourite(widget.singleProduct);
                            showToast("Added to wishlist");}

                        },
                        child: Text(
                          appProvider.GetFavoutireList.contains(
                                  widget.singleProduct)
                              ? "Remove From Wishlist"
                              : "Add To Wishlist",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 15),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            appProvider.removeCartProduct(widget.singleProduct);
                            showToast("Item removed successfully");
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            size: 30,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
