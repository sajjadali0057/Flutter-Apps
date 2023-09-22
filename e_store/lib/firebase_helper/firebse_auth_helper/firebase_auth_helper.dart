import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_store/constants/toast.dart';
import 'package:e_store/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class firebase_auth_helper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool?> signin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showToast('No Internet Connection');
        //devtools.log('No Internet Connection');
      } else if (e.code == "wrong-password") {
        showToast('Please Enter correct password');
        //devtools.log('Please Enter correct password');
        //print('Please Enter correct password');
      } else if (e.code == 'user-not-found') {
        showToast('Email not found');
        // print('Email not found');
      } else if (e.code == 'too-many-requests') {
        showToast('Too many attempts please try later');
        //print('Too many attempts please try later');
      } else if (e.code == 'unknown') {
        showToast(
            'Email and password field are required');
        //print('Email and password field are required');
      } else if (e.code == 'unknown') {
        showToast(
            'Email and Password Fields are required');
        //print(e.code);
      } else {
        showToast(e.code);
      }
    }
    return null;
  }

  Future<bool?> varified() async {
    final currentUser = _auth.currentUser;
    if (currentUser!.emailVerified) {
      return true;
    }
    return null;
  }

  Future<bool?> signup(email, password, name, phone,address) async {
    try {
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(id: userCredential.user!.uid,
          image: null,
          name: name,
          email: email,
          phone: phone, address: "");
      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      final currentUser = _auth.currentUser;
      currentUser?.sendEmailVerification();
      showToast(
          "Account has created successfully\n""Please varify your account from the link sent to your email ");
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      }
    }
    return null;
  }

  Future<bool?> resetPassword(String email) async {
    try {
      final validate = await _auth.fetchSignInMethodsForEmail(email.toString());
      if (
      validate.isEmpty
      ) {
        showToast("This user doesn't exist");
        return false;
      }
      else {
        try {
          _auth.sendPasswordResetEmail(email: email.toString());
          showToast("Password link has been sent \n Please check your email");
          return true;
        }
        catch (e) {
          showToast(e.toString());
          return false;
        }
      }
    }
    catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  Future<bool?> checkLogin() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> changePassword(BuildContext context,String passwordcontroller) async {
    try {
      _auth.currentUser!.updatePassword(passwordcontroller.toString());
      showToast("Password Changed Successfully");
      Navigator.pop(context);
      return true;
    }
    catch (e) {
      showToast(e.toString());
      return false;
    }
  }

  Future<bool?> logout() async {
    try {
      await _auth.signOut();
      showToast("Logged out successfully");
      return true;
    }
    catch (e) {
      showToast(e.toString());
      return false;
    }
  }

}
