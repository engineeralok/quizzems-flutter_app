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
    apiKey: 'AIzaSyAB-B7WRtcLtwAHgfYrFpvCgHI_7zY7oPU',
    appId: '1:644412442948:web:86cd06e2112bf264702f11',
    messagingSenderId: '644412442948',
    projectId: 'quizzems-c2d8f',
    authDomain: 'quizzems-c2d8f.firebaseapp.com',
    storageBucket: 'quizzems-c2d8f.appspot.com',
    measurementId: 'G-W8BL65TFEW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa5b5fLCod2z6xKuUCk5nsWeiLm2oSB0Y',
    appId: '1:644412442948:android:e78b72e2404efd4f702f11',
    messagingSenderId: '644412442948',
    projectId: 'quizzems-c2d8f',
    storageBucket: 'quizzems-c2d8f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8qQwjOcbbWYeCsbFtqHmL__4SgdQSCQ8',
    appId: '1:644412442948:ios:1bb6e58294f2e09c702f11',
    messagingSenderId: '644412442948',
    projectId: 'quizzems-c2d8f',
    storageBucket: 'quizzems-c2d8f.appspot.com',
    iosClientId: '644412442948-1skhdt883jkcc7kqom7dv2qt14oa4up3.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizzems',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8qQwjOcbbWYeCsbFtqHmL__4SgdQSCQ8',
    appId: '1:644412442948:ios:0984c66d511d721f702f11',
    messagingSenderId: '644412442948',
    projectId: 'quizzems-c2d8f',
    storageBucket: 'quizzems-c2d8f.appspot.com',
    iosClientId: '644412442948-s20ifemth3epfblhl59uhi4qokam6505.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizzems.RunnerTests',
  );
}