import 'package:micasa/widget/home_page.dart';
import 'package:micasa/widget/login_page.dart';
import 'package:micasa/widget/register_page.dart';
import 'package:micasa/widget/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MiCasa());

class MiCasa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiCasa',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: <String, WidgetBuilder> {
        '/': (_) => SplashPage(),
        '/home': (_) => HomePage(),
        '/login': (_) => LogInPage(),
        '/register': (_) => RegisterPage(),
      },
    );
  }
}