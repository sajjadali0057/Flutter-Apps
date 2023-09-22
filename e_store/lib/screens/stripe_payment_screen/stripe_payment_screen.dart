import 'dart:convert';
import 'package:e_store/constants/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePayment {
  static StripePayment instance = StripePayment();
  Map<String, dynamic>? paymentIntentData;

  Future<bool> makePayment(String total) async {

    try {
      paymentIntentData = await createPaymentIntent(total, "USD");
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: 'USD', testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        googlePay: gpay,
        style: ThemeMode.system,
        merchantDisplayName: 'Easy Shopping',
      ));
      displayPaymentSheet();
      return true;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51NsZ2UGv2Em79PeDwgSf9djxVvYdyUkbBMndzVzdpEXivzbXB4sYjkvqiHUNWT4HgONmHqqoHfSGFLtCUpUoUy4o00rkt2ERlk',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      showToast(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
     await Stripe.instance.presentPaymentSheet(

      ).then((value) {
       paymentIntentData = null;
        showToast("Payment Successful");
      });


    } catch (e) {

      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
