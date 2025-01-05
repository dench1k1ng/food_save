// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBQceGiQ6Rqw_yauk-71iVtXw59tHE7tlY',
    appId: '1:59514310363:web:1e6af0bd35ed0aceac86fe',
    messagingSenderId: '59514310363',
    projectId: 'food-save-f4f89',
    authDomain: 'food-save-f4f89.firebaseapp.com',
    storageBucket: 'food-save-f4f89.firebasestorage.app',
    measurementId: 'G-G3V11KLNKE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx-OJlryyEKB6wgC7iwSUar9iYQibzM3c',
    appId: '1:59514310363:android:f050309da262e950ac86fe',
    messagingSenderId: '59514310363',
    projectId: 'food-save-f4f89',
    storageBucket: 'food-save-f4f89.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWk0m-ZRoSgBNB79wA0J-MPXpo_GHWHpo',
    appId: '1:59514310363:ios:87c9be99ebbe51ceac86fe',
    messagingSenderId: '59514310363',
    projectId: 'food-save-f4f89',
    storageBucket: 'food-save-f4f89.firebasestorage.app',
    iosBundleId: 'com.example.foodSave',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWk0m-ZRoSgBNB79wA0J-MPXpo_GHWHpo',
    appId: '1:59514310363:ios:87c9be99ebbe51ceac86fe',
    messagingSenderId: '59514310363',
    projectId: 'food-save-f4f89',
    storageBucket: 'food-save-f4f89.firebasestorage.app',
    iosBundleId: 'com.example.foodSave',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQceGiQ6Rqw_yauk-71iVtXw59tHE7tlY',
    appId: '1:59514310363:web:9734da73643617e1ac86fe',
    messagingSenderId: '59514310363',
    projectId: 'food-save-f4f89',
    authDomain: 'food-save-f4f89.firebaseapp.com',
    storageBucket: 'food-save-f4f89.firebasestorage.app',
    measurementId: 'G-TBCGBGFXZQ',
  );
}
