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
    apiKey: 'AIzaSyAZuSnLiS-VEls9e9eAR5XxDuNrsAFZ8Eg',
    appId: '1:632335899087:web:bf8552f701968d54181aba',
    messagingSenderId: '632335899087',
    projectId: 'nmims-leave-portal',
    authDomain: 'nmims-leave-portal.firebaseapp.com',
    storageBucket: 'nmims-leave-portal.appspot.com',
    measurementId: 'G-X5KG8ZFMN6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDb2nu4F8KTz4RaDyLi09MLXuCwKLPWcCE',
    appId: '1:632335899087:android:26f9c2d7d18ccbba181aba',
    messagingSenderId: '632335899087',
    projectId: 'nmims-leave-portal',
    storageBucket: 'nmims-leave-portal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrL6r0QKFizL2o4gGZMMjPLRelAV-AI34',
    appId: '1:632335899087:ios:c71e0ab855d86635181aba',
    messagingSenderId: '632335899087',
    projectId: 'nmims-leave-portal',
    storageBucket: 'nmims-leave-portal.appspot.com',
    iosClientId: '632335899087-jvheb5ku37joeht98thnkumdhqse99ht.apps.googleusercontent.com',
    iosBundleId: 'com.example.nmimsLeavePortal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrL6r0QKFizL2o4gGZMMjPLRelAV-AI34',
    appId: '1:632335899087:ios:ba9e9bf9b193b567181aba',
    messagingSenderId: '632335899087',
    projectId: 'nmims-leave-portal',
    storageBucket: 'nmims-leave-portal.appspot.com',
    iosClientId: '632335899087-2vn5le54uqmed1nbfg2gg99a2ndv1a5s.apps.googleusercontent.com',
    iosBundleId: 'com.example.nmimsLeavePortal.RunnerTests',
  );
}
