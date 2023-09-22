// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCxFtIGczWtU6fDKi6TWgFdsMXgIDxL-6s',
    appId: '1:122195605002:web:fe5c3c2db9ee9fc039d1f3',
    messagingSenderId: '122195605002',
    projectId: 'e-store-e5e81',
    authDomain: 'e-store-e5e81.firebaseapp.com',
    storageBucket: 'e-store-e5e81.appspot.com',
    measurementId: 'G-V7BWQN03V2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdmCPB4bhy7b0kI_jDx1OrsGzh9BKZYXQ',
    appId: '1:122195605002:android:edafd63d61323e2d39d1f3',
    messagingSenderId: '122195605002',
    projectId: 'e-store-e5e81',
    storageBucket: 'e-store-e5e81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN-zH9bFIHUu_bf8KNBkzUWyDuRWdacaM',
    appId: '1:122195605002:ios:b4259c0d896f515f39d1f3',
    messagingSenderId: '122195605002',
    projectId: 'e-store-e5e81',
    storageBucket: 'e-store-e5e81.appspot.com',
    iosClientId: '122195605002-hm9ncsu9nss20gmo9ro7qn2ci0eshaq6.apps.googleusercontent.com',
    iosBundleId: 'com.example.eStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDN-zH9bFIHUu_bf8KNBkzUWyDuRWdacaM',
    appId: '1:122195605002:ios:43ff94108ba2e4d339d1f3',
    messagingSenderId: '122195605002',
    projectId: 'e-store-e5e81',
    storageBucket: 'e-store-e5e81.appspot.com',
    iosClientId: '122195605002-hgvbc357647oivmhk9ene8n2b6nfibv2.apps.googleusercontent.com',
    iosBundleId: 'com.example.eStore.RunnerTests',
  );
}