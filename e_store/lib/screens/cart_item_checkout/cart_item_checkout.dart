import 'package:e_store/constants/circularindicator.dart';
import 'package:e_store/constants/routes.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/firebase_helper/firebasefirestore_helper/firebase_firestore_helper.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_store/widgets/elevatedbutton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stripe_payment_screen/stripe_payment_screen.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({super.key});

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 2;

  int? value;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.getCheckoutProductsList.length;
    bool circular = false;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Checkout",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
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
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });
                    final price =
                        double.parse(appProvider.totalPrice().toString())
                            .round()
                            .toInt();
                    final finalprice = price * 100;
                    if (groupValue != 1) {
                      bool issuccessfullPayment = await StripePayment.instance
                          .makePayment(finalprice.toString());
                      if (issuccessfullPayment) {
                        setState(() {
                          circular = true;
                        });
                        bool check = await FirebaseFirestoreHelper.instance
                            .uploadOrderProductsFirebase(
                                appProvider.getCheckoutProductsList, 'Paid');

                        if (check) {
                          Future.delayed(const Duration(seconds: 1), () {
                            appProvider.clearCheckoutProducts();
                            Routes.instance.PushandRemoveUntil(
                                context: context,
                                widget: const CustomBottomBar());
                          });
                        } else {
                          setState(() {
                            circular = false;
                          });
                          showToast("Order Not placed");
                        }
                      }
                    } else {
                      bool check = await FirebaseFirestoreHelper.instance
                          .uploadOrderProductsFirebase(
                              appProvider.getCheckoutProductsList,
                              'Cash On Delivery');

                      if (check) {
                        Future.delayed(const Duration(seconds: 1), () {
                          appProvider.clearCheckoutProducts();
                          Routes.instance.PushandRemoveUntil(
                              context: context,
                              widget: const CustomBottomBar());
                          showToast("Order Placed Successfully");
                        });
                      } else {
                        setState(() {
                          circular = false;
                        });
                        showToast("Order Not placed");
                      }
                    }
                  },
                  name: "CheckOut"),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      body: circular
          ? const Center(
              child: showCircular(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.money_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.credit_card_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Visa / Debit Card",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // Expanded(child: Container()),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade100,
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(
                  //       color: Colors.black54,
                  //
                  //     )
                  //   ),
                  //
                  //   // child: Padding(
                  //   //   padding: const EdgeInsets.all(8.0),
                  //   //   child: Row(
                  //   //     crossAxisAlignment: CrossAxisAlignment.start,
                  //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //     children: [
                  //   //       Text(
                  //   //         "Total",
                  //   //         style: TextStyle(
                  //   //             fontSize: 18, fontWeight: FontWeight.bold),
                  //   //       ),
                  //   //       Text(
                  //   //         "\$150",
                  //   //         style: TextStyle(
                  //   //             fontSize: 18, fontWeight: FontWeight.bold),
                  //   //       ),
                  //   //     ],
                  //   //   ),
                  //   // ),
                  // ),
                  // PrimaryButton(onPressed: (){}, name: "Checkout"),
                  // SizedBox(height: 60,)
                ],
              )),
    );
  }
}
// class CustomRadio extends StatefulWidget {
//   final int value;
//   final void Function(int) onChanged;
//
//  final int groupValue;
//   CustomRadio({Key? key, required this.value, required this.groupValue, required this.onChanged})
//       : super(key: key);
//
//   @override
//   _CustomRadioState createState() => _CustomRadioState();
// }
//
// class _CustomRadioState extends State<CustomRadio> {
//   @override
//   Widget build(BuildContext context) {
//     bool selected = (widget.value == widget.groupValue);
//
//     return InkWell(
//       onTap: () => widget.onChanged(widget.value),
//       child: Radio(value: widget.value, groupValue: widget.groupValue, onChanged: (int? value) {  },)
//     );
//   }
// }
