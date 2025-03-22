// Generated file. Do not edit.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'DefaultFirebaseOptions are not supported for windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAOHNRuid97Dbt3UVmnK-DlHd_UUoJ-mro",
    authDomain: "healthcarefinder-161ee.firebaseapp.com",
    projectId: "healthcarefinder-161ee",
    storageBucket: "healthcarefinder-161ee.appspot.com",
    messagingSenderId: "60310906769",
    appId: "1:60310906769:web:75b98a7a67d7198daedc30",
    measurementId: "G-MDM9GJ7LPS",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "YOUR_ANDROID_API_KEY",
    appId: "YOUR_ANDROID_APP_ID",
    messagingSenderId: "YOUR_ANDROID_MESSAGING_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_ANDROID_STORAGE_BUCKET",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "YOUR_IOS_API_KEY",
    appId: "YOUR_IOS_APP_ID",
    messagingSenderId: "YOUR_IOS_MESSAGING_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_IOS_STORAGE_BUCKET",
    iosClientId: "YOUR_IOS_CLIENT_ID",
    iosBundleId: "YOUR_IOS_BUNDLE_ID",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "YOUR_MACOS_API_KEY",
    appId: "YOUR_MACOS_APP_ID",
    messagingSenderId: "YOUR_MACOS_MESSAGING_SENDER_ID",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_MACOS_STORAGE_BUCKET",
    iosClientId: "YOUR_MACOS_CLIENT_ID",
    iosBundleId: "YOUR_MACOS_BUNDLE_ID",
  );
}