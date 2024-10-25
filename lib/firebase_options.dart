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
    apiKey: 'AIzaSyDJHT1rCf5bKKRZicdbqwkNdt5hlAGbkRI',
    appId: '1:742237911371:web:ed8117805876eb954bd0ce',
    messagingSenderId: '742237911371',
    projectId: 'final-exam-33c1f',
    authDomain: 'final-exam-33c1f.firebaseapp.com',
    storageBucket: 'final-exam-33c1f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfcO47ckThVe1P1XW0rGwxBlONuKzb_ZM',
    appId: '1:742237911371:android:17d71fd33ecb69be4bd0ce',
    messagingSenderId: '742237911371',
    projectId: 'final-exam-33c1f',
    storageBucket: 'final-exam-33c1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzfv4rkvHDAaEqeazxttzZBpzFX7ikQAw',
    appId: '1:742237911371:ios:32779bacd4e007354bd0ce',
    messagingSenderId: '742237911371',
    projectId: 'final-exam-33c1f',
    storageBucket: 'final-exam-33c1f.appspot.com',
    iosBundleId: 'com.example.finalExam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzfv4rkvHDAaEqeazxttzZBpzFX7ikQAw',
    appId: '1:742237911371:ios:32779bacd4e007354bd0ce',
    messagingSenderId: '742237911371',
    projectId: 'final-exam-33c1f',
    storageBucket: 'final-exam-33c1f.appspot.com',
    iosBundleId: 'com.example.finalExam',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDJHT1rCf5bKKRZicdbqwkNdt5hlAGbkRI',
    appId: '1:742237911371:web:dfd57331706fd0e34bd0ce',
    messagingSenderId: '742237911371',
    projectId: 'final-exam-33c1f',
    authDomain: 'final-exam-33c1f.firebaseapp.com',
    storageBucket: 'final-exam-33c1f.appspot.com',
  );
}