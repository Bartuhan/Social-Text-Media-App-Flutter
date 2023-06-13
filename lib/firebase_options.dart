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
    apiKey: 'AIzaSyBbR99-0K7smBVDhfVTTCMCVjQ8dJpgSso',
    appId: '1:152765674586:web:90c5258e68d97109509463',
    messagingSenderId: '152765674586',
    projectId: 'walltutorial-a6749',
    authDomain: 'walltutorial-a6749.firebaseapp.com',
    storageBucket: 'walltutorial-a6749.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB48Zz18WqUrDzDsBBmCMpWxlNazFpA9Tw',
    appId: '1:152765674586:android:72528a150a72df93509463',
    messagingSenderId: '152765674586',
    projectId: 'walltutorial-a6749',
    storageBucket: 'walltutorial-a6749.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIWiPU2IJOxuL27Q3pAEAqQyKoJC8ElKg',
    appId: '1:152765674586:ios:70ff895f33aa81fb509463',
    messagingSenderId: '152765674586',
    projectId: 'walltutorial-a6749',
    storageBucket: 'walltutorial-a6749.appspot.com',
    iosClientId: '152765674586-dr8lk1mgdh8f46jcdai1pa48rf3fd74l.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIWiPU2IJOxuL27Q3pAEAqQyKoJC8ElKg',
    appId: '1:152765674586:ios:70ff895f33aa81fb509463',
    messagingSenderId: '152765674586',
    projectId: 'walltutorial-a6749',
    storageBucket: 'walltutorial-a6749.appspot.com',
    iosClientId: '152765674586-dr8lk1mgdh8f46jcdai1pa48rf3fd74l.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp',
  );
}