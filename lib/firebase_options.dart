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
    apiKey: 'AIzaSyCd8FB6chYw4X5UUIhCX1AP45V3WudQ7Wc',
    appId: '1:31897487155:web:fd6a5c062180ac77196046',
    messagingSenderId: '31897487155',
    projectId: 'emart-9aac6',
    authDomain: 'emart-9aac6.firebaseapp.com',
    storageBucket: 'emart-9aac6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCX0taxgBDf2Eou7GNznkRzUg-f_rU0Vr4',
    appId: '1:31897487155:android:00fe3b6ec53988db196046',
    messagingSenderId: '31897487155',
    projectId: 'emart-9aac6',
    storageBucket: 'emart-9aac6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4seUBB3ozWt871Wv-3gemgPr0CtZuKDo',
    appId: '1:31897487155:ios:2884f1f52de4d85a196046',
    messagingSenderId: '31897487155',
    projectId: 'emart-9aac6',
    storageBucket: 'emart-9aac6.appspot.com',
    iosBundleId: 'com.example.emartApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4seUBB3ozWt871Wv-3gemgPr0CtZuKDo',
    appId: '1:31897487155:ios:f249d6647af0926a196046',
    messagingSenderId: '31897487155',
    projectId: 'emart-9aac6',
    storageBucket: 'emart-9aac6.appspot.com',
    iosBundleId: 'com.example.emartApp.RunnerTests',
  );
}
