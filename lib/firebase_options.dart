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
    apiKey: 'AIzaSyAgUPdx7OIoPq4eMcwH-NuAjrElxjR1o20',
    appId: '1:899529344401:web:b96ccbe4969e0c084f0630',
    messagingSenderId: '899529344401',
    projectId: 'fluttergram-cab43',
    authDomain: 'fluttergram-cab43.firebaseapp.com',
    storageBucket: 'fluttergram-cab43.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPCseBgo8nutyULIuElY2l5VjVhVmVWdU',
    appId: '1:899529344401:android:aa4e6edc229189514f0630',
    messagingSenderId: '899529344401',
    projectId: 'fluttergram-cab43',
    storageBucket: 'fluttergram-cab43.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB34HZtvKNxwa76n4xDHSknki84DeQbXLo',
    appId: '1:899529344401:ios:3849750391695c094f0630',
    messagingSenderId: '899529344401',
    projectId: 'fluttergram-cab43',
    storageBucket: 'fluttergram-cab43.appspot.com',
    iosClientId: '899529344401-915d8p800annneeuqlrq0l1hbo25gcgv.apps.googleusercontent.com',
    iosBundleId: 'com.sidlab.instagram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB34HZtvKNxwa76n4xDHSknki84DeQbXLo',
    appId: '1:899529344401:ios:27bfb5820da7b5e14f0630',
    messagingSenderId: '899529344401',
    projectId: 'fluttergram-cab43',
    storageBucket: 'fluttergram-cab43.appspot.com',
    iosClientId: '899529344401-s6u03tmj7snimiiqr4e82epv4orlnmuo.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagram.RunnerTests',
  );
}
