import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging firebaseMessaging;

Future<void> initNotification() async {
  firebaseMessaging = FirebaseMessaging()
    ..requestNotificationPermissions()
    ..onIosSettingsRegistered.listen((IosNotificationSettings settings) {})
    ..configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onBackgroundMessage:
        Platform.isAndroid ? myBackgroundMessageHandler : null,
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );

  firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    print("Push Messaging token: $token");
  });
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
  print('onBackground: $message');
}
