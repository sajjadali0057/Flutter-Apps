import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../constants/toast.dart';
import 'package:http/http.dart' as http;

class StripeHelper {
  static StripeHelper instance = StripeHelper();
  Map<String, dynamic>? paymentIntent;
  Future<bool> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent("1000", 'USD');
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: 'USD', testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: "Easy Shopping",
              googlePay: gpay)).then((value) {});
      displayPaymentSheet();
      return true;
    }
    catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  Future<bool>displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showToast("Payment Successful");

      }

      );
      return true;

    }
    catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic>body = {
        'amount': amount,
        'currency': currency
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
    headers :{
        'Authorization':'Bearer sk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTIHYbZ8jQIGtVFlwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRIwoTVRFXyu2h00mRUeWmAf',
        'Content-Type':'application/x-www-form-urlencoded'
    },
    body:body,
    );
return json.decode(response.body);
    }
    catch(e){
      showToast(e.toString());
      throw Exception(e.toString());

    }
  }
}