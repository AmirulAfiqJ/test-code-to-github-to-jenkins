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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAkw5kfpJGjlwaku61XzsIxg0X2lemC6l4',
    appId: '1:479036384065:web:86ed3cdd95ec80bfeb77c0',
    messagingSenderId: '479036384065',
    projectId: 'bizapptrackallonlineuser',
    authDomain: 'bizapptrackallonlineuser.firebaseapp.com',
    databaseURL: 'https://bizapptrackallonlineuser.firebaseio.com',
    storageBucket: 'bizapptrackallonlineuser.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1U8Bj4LNFh6Pz4M43pY_IEBwhAkg76u8',
    appId: '1:479036384065:android:580b0c53d4723cb6eb77c0',
    messagingSenderId: '479036384065',
    projectId: 'bizapptrackallonlineuser',
    databaseURL: 'https://bizapptrackallonlineuser.firebaseio.com',
    storageBucket: 'bizapptrackallonlineuser.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4KCJWecKL6eOsr_i0sPA8nsWhTeOcPRw',
    appId: '1:479036384065:ios:2472540269c3061eeb77c0',
    messagingSenderId: '479036384065',
    projectId: 'bizapptrackallonlineuser',
    databaseURL: 'https://bizapptrackallonlineuser.firebaseio.com',
    storageBucket: 'bizapptrackallonlineuser.appspot.com',
    iosClientId: '479036384065-7663vr1svb2f2l371i3sdha5a1mf455h.apps.googleusercontent.com',
    iosBundleId: 'com.example.bizapptrack',
  );
}