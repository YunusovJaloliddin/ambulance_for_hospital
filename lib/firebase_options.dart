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
    apiKey: 'AIzaSyDwiQVXQL9wwDAUZXHzN4WdpvcHahrVjjs',
    appId: '1:712486681839:web:13cfdea2bf73d8bdf2ef1a',
    messagingSenderId: '712486681839',
    projectId: 'ambulanceuzb',
    authDomain: 'ambulanceuzb.firebaseapp.com',
    databaseURL: 'https://ambulanceuzb-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ambulanceuzb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHzOfAI50xIiRp5U3jFUWjhyz4Y00bjPU',
    appId: '1:712486681839:android:f9d86cb24c6f5027f2ef1a',
    messagingSenderId: '712486681839',
    projectId: 'ambulanceuzb',
    databaseURL: 'https://ambulanceuzb-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ambulanceuzb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsNg2Q7OwXTju4bZzVTCULn_9S3HvAAZk',
    appId: '1:712486681839:ios:a6da88ca0188745af2ef1a',
    messagingSenderId: '712486681839',
    projectId: 'ambulanceuzb',
    databaseURL: 'https://ambulanceuzb-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ambulanceuzb.appspot.com',
    iosBundleId: 'com.example.ambulanceForHospital',
  );
}
