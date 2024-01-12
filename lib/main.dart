import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _permission();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print("ipansuryadi $fcmToken");
  }

  await FirebaseMessaging.instance.subscribeToTopic("ngetest");

  FirebaseMessaging.onMessage.listen((message) {
    if (kDebugMode) {
      // ignore: prefer_interpolation_to_compose_strings
      print("data nya ini : " + message.data['data']);
      // ignore: prefer_interpolation_to_compose_strings
      print("type nya ini : " + message.data['type']);
      print("type ini string bukan ya?");
      print(message.data['type'] == "NOTIFICATION_TYPE");
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _permission() async {
  await FirebaseMessaging.instance.requestPermission(provisional: true);

  // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
  }
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {})
      .onError((err) {});
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.data.toString());
  }
}
