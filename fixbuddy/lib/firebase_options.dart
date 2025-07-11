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
    apiKey: 'AIzaSyCx41x8Bzg1AuFgfTTc9DvoXwrZxtV7cpQ',
    appId: '1:212009380231:web:fdd69c70fcb3f6c0938b22',
    messagingSenderId: '212009380231',
    projectId: 'fixbuddy-5a8ea',
    authDomain: 'fixbuddy-5a8ea.firebaseapp.com',
    storageBucket: 'fixbuddy-5a8ea.firebasestorage.app',
    measurementId: 'G-9PR00JFKR6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClhNlenZ7njhSBnRXlfV_H0807TnVg8lM',
    appId: '1:212009380231:android:8974c926c78549dc938b22',
    messagingSenderId: '212009380231',
    projectId: 'fixbuddy-5a8ea',
    storageBucket: 'fixbuddy-5a8ea.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeSe5s3RWPHMbmbZ6vpS_l3orW-WRCLmM',
    appId: '1:212009380231:ios:efeb9907312e80bf938b22',
    messagingSenderId: '212009380231',
    projectId: 'fixbuddy-5a8ea',
    storageBucket: 'fixbuddy-5a8ea.firebasestorage.app',
    iosBundleId: 'com.example.fixbuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAeSe5s3RWPHMbmbZ6vpS_l3orW-WRCLmM',
    appId: '1:212009380231:ios:efeb9907312e80bf938b22',
    messagingSenderId: '212009380231',
    projectId: 'fixbuddy-5a8ea',
    storageBucket: 'fixbuddy-5a8ea.firebasestorage.app',
    iosBundleId: 'com.example.fixbuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCx41x8Bzg1AuFgfTTc9DvoXwrZxtV7cpQ',
    appId: '1:212009380231:web:8e569f9ca61396bb938b22',
    messagingSenderId: '212009380231',
    projectId: 'fixbuddy-5a8ea',
    authDomain: 'fixbuddy-5a8ea.firebaseapp.com',
    storageBucket: 'fixbuddy-5a8ea.firebasestorage.app',
    measurementId: 'G-8R5KSD9KMN',
  );

}