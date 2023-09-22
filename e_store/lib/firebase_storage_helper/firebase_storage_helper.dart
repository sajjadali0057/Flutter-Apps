
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper{
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  Future<String>uploadUserImage(File image)async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    String userId= FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot =await _storage.ref(userId).putFile(image);
    String imgUrl = await taskSnapshot.ref.getDownloadURL();
    return imgUrl;
  }
}