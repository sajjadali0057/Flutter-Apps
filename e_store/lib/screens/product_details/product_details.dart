import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/cart_screen/cart_screen.dart';
import 'package:e_store/screens/checkout_screen/checkout_screen.dart';
import 'package:e_store/screens/favourite_screen/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
    required this.singleProduct,
  });

  final singleProduct;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of(context,listen: false);
    ProductModel productModel;
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)),
            Expanded(child: Container()),
            // IconButton(
            //     onPressed: () {
            //       Routes.instance.Push(context: context, widget: CartScreen());
            //     },
            //     icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: Padding(

            padding: EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                      child: Image.network(widget.singleProduct.image),
                      width: 400,
                      height: MediaQuery.of(context).size.height - 600),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.singleProduct.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            setState((){
                              widget.singleProduct.isFavourite=!widget.singleProduct.isFavourite;
                            });
                            if (widget.singleProduct.isFavourite) {
                              appProvider.addFavourite(widget.singleProduct);

                              showToast("Added to wishlist");
                            }
                            else{
                              appProvider.removeFavourite(widget.singleProduct);
                              showToast("Removed from wishlist");
                            }
                          },
                          icon: Icon(
                           appProvider.GetFavoutireList.contains(widget.singleProduct)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 27,
                          )),
                    ],
                  ),
                  Text(
                    widget.singleProduct.description,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (quantity >= 1) {
                              quantity--;
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
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
                        width: 14,
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 40,
                        child: OutlinedButton(
                            onPressed: () {
                              productModel = widget.singleProduct
                                  .copyWith(quantity: quantity);
                              appProvider.addCartProduct(productModel);
                              showToast("Added To Cart Successfully");
                            },
                            child: Text("Add To Cart",
                                style: TextStyle(color: Colors.deepOrange))),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    productModel = widget.singleProduct
                                        .copyWith(quantity: quantity);
                                    Routes.instance.Push(context: context, widget: CheckOutScreen(singleProduct: productModel,));
                                  }, child: Text("Buy")))),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).devicePixelRatio+70,
                  )
                ],
              ),
            )));
  }
}
