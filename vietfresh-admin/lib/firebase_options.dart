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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBe23ljcTTIIPCgWI4fBC1guDGGSBFeO7c',
    appId: '1:2028419222:android:0eeae7935c773f3d582ab7',
    messagingSenderId: '2028419222',
    projectId: 'vietfresh-6acc6',
    databaseURL: 'https://vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'vietfresh-6acc6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjVkCekdvjDXz2-jikm-q-0c1VfDlr96k',
    appId: '1:2028419222:ios:13007242db9ee902582ab7',
    messagingSenderId: '2028419222',
    projectId: 'vietfresh-6acc6',
    databaseURL: 'https://vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'vietfresh-6acc6.appspot.com',
    iosBundleId: 'com.example.admin',
  );
}
