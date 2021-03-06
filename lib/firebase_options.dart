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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBOjAHScDLbg7Sj1To1hUF9G0WgfDoYoLI',
    appId: '1:679599714754:web:d7799135f55aa9cb67a65b',
    messagingSenderId: '679599714754',
    projectId: 'saver-65cb3',
    authDomain: 'saver-65cb3.firebaseapp.com',
    storageBucket: 'saver-65cb3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqFN87_SrQyRt2luPHqGNlH1Gj4h0hW4k',
    appId: '1:679599714754:android:03e93bec68ba84a467a65b',
    messagingSenderId: '679599714754',
    projectId: 'saver-65cb3',
    storageBucket: 'saver-65cb3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsfXR0TlfrClGjndeaqI_0mksCCcmqKRc',
    appId: '1:679599714754:ios:a604dd0cf8b2369667a65b',
    messagingSenderId: '679599714754',
    projectId: 'saver-65cb3',
    storageBucket: 'saver-65cb3.appspot.com',
    iosClientId: '679599714754-25s95dnfafo2n7ivgrtgt4u4jaa46rhu.apps.googleusercontent.com',
    iosBundleId: 'com.example.saver',
  );
}
