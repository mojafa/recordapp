// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCbQJvhrQQOrEJUwoRiJI_eVpchHKxCRco',
    appId: '1:569135116717:web:45f6759b8d14c2f751f124',
    messagingSenderId: '569135116717',
    projectId: 'audio-project-b56de',
    authDomain: 'audio-project-b56de.firebaseapp.com',
    storageBucket: 'audio-project-b56de.appspot.com',
    measurementId: 'G-KPTBJJS9SS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrIWQYagb5-BZkeorNNP5rzwbSVls6fK8',
    appId: '1:569135116717:android:808870a9391ae7da51f124',
    messagingSenderId: '569135116717',
    projectId: 'audio-project-b56de',
    storageBucket: 'audio-project-b56de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrZVWIqWsyc_JiYLY9EXb_3RDXlJTkFYE',
    appId: '1:569135116717:ios:deaa3f65be0c43e151f124',
    messagingSenderId: '569135116717',
    projectId: 'audio-project-b56de',
    storageBucket: 'audio-project-b56de.appspot.com',
    iosClientId: '569135116717-d0tgnr8qv2g0l769e4d7mu1m6q2e1558.apps.googleusercontent.com',
    iosBundleId: 'com.khaire.app',
  );
}
