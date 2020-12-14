import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../notification.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    RemoteNotificationsHelper().initNotification();
    Firebase.initializeApp().whenComplete(() {
      Future.delayed(const Duration(seconds: 3))
          .then((value) => handleTimeout());
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

  void handleTimeout() {
    Navigator.of(context).pushReplacementNamed("/login");
  }
}