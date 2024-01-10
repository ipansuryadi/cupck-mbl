import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> firebaseSetup() async {
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {})
      .onError((err) {});

  final fcmToken = await FirebaseMessaging.instance.getToken();

  debugPrint("ipansuryadi $fcmToken");

  await FirebaseMessaging.instance.subscribeToTopic("ngetest");

  FirebaseMessaging.onBackgroundMessage(
    (message) async {
      debugPrint(message.data.toString());
    },
  );
}

Future<void> permission() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // You may set the permission requests to "provisional" which allows the user to choose what type
  // of notifications they would like to receive once the user receives a notification.
  await FirebaseMessaging.instance.requestPermission(provisional: true);

  // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {}
}
