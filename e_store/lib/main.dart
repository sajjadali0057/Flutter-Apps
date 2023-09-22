import 'package:e_store/constants/splash.dart';
import 'package:e_store/provider/app_provider.dart';
import 'package:e_store/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_store/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51NsZ2UGv2Em79PeD2dYx3n1Z5qwZfIwTO0FThcYcygwUNeQVQN8Sl1BPFNv4ZmqCRN5h3DNgrG5r1IwlitwtUrnX00CObnPQAL';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  ChangeNotifierProvider<AppProvider> build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
          title: 'Easy Shopping',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: const splashScreen()
          // Container(child: CustomBottomBar(),)
          ),
    );
  }
}
