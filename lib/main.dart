import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micasa_flutter/fcm_provider.dart';

void main() => runApp(MiCasa());

class MiCasa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MiCasa',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(title: 'MiCasa'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

      ),
    );
  }
}