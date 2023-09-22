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
    apiKey: 'AIzaSyBPnuR9sLs-d5nX28_MEsiELc_abriG83g',
    appId: '1:778037989121:web:e83a7de1e6b3c7f6171500',
    messagingSenderId: '778037989121',
    projectId: 'todo-app-26e07',
    authDomain: 'todo-app-26e07.firebaseapp.com',
    storageBucket: 'todo-app-26e07.appspot.com',
    measurementId: 'G-7B93S0RGNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmt0IH9yh7AZdo7Knyg0L5D7MxeDiJjq8',
    appId: '1:778037989121:android:612faad1f01d4380171500',
    messagingSenderId: '778037989121',
    projectId: 'todo-app-26e07',
    storageBucket: 'todo-app-26e07.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBItvd5O7hBLQzI4d9l8ErzaXI68wxfWfU',
    appId: '1:778037989121:ios:f5a6ee17f88cfd4f171500',
    messagingSenderId: '778037989121',
    projectId: 'todo-app-26e07',
    storageBucket: 'todo-app-26e07.appspot.com',
    iosClientId: '778037989121-86jb9amnaemktgr2kkm9l56akg4e9smf.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBItvd5O7hBLQzI4d9l8ErzaXI68wxfWfU',
    appId: '1:778037989121:ios:b6074e3c1a2d4c4d171500',
    messagingSenderId: '778037989121',
    projectId: 'todo-app-26e07',
    storageBucket: 'todo-app-26e07.appspot.com',
    iosClientId: '778037989121-29af8j55ic4v1as45t0k28h1roq2tvaf.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApplication.RunnerTests',
  );
}