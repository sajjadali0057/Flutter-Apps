import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_application/home_page.dart';

class AuthClass {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  get id => null;

  Future<void> googleSignin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.idToken);
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          storeTokenAndData(userCredential);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage()));
        } catch (e) {}
      }
    } catch (e) {}
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }
  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> logout() async {
    try {
      await googleSignIn.signOut();
      await storage.delete(key: 'token');
      await auth.signOut();
    } catch (e) {}
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, 'Verification Completed');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (String verificationID, [int? forResending]) {
      showSnackBar(context, "Code Sent");
      setData(verificationID);
    } as PhoneCodeSent;
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, 'Timout');
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {}
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try{
      AuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => HomePage()), (route) => false);
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


