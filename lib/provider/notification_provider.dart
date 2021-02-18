import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class RemoteNotificationsProvider {
  FirebaseMessaging firebaseMessaging;

  Future<void> initNotification() async {
    firebaseMessaging = FirebaseMessaging()
      ..requestNotificationPermissions(
          const IosNotificationSettings(sound: true, alert: true, badge: true)
      )
      ..onIosSettingsRegistered.listen(
              (IosNotificationSettings settings) {
                print("Settings registered: $settings");
              })
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
    firebaseMessaging.getToken().then((String token) => print(token));
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
}
