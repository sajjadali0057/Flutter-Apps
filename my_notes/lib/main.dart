import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes/Screens/home_screen.dart';
import 'package:my_notes/Screens/phone_login.dart';
import 'package:my_notes/Screens/signup_screen.dart';
import 'Screens/addnote_screen.dart';
import 'Screens/signin_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

