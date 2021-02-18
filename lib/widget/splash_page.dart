import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micasa/provider/user_provider.dart';
import '../provider/notification_provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    RemoteNotificationsProvider().initNotification();
    Firebase.initializeApp().whenComplete(() {
      Future.delayed(const Duration(seconds: 3))
          .then((value) => UserProvider().checkUser(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
