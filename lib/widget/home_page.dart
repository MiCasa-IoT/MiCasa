import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micasa/provider/bluetooth_provider.dart';
import 'package:micasa/provider/user_provider.dart';

class HomePage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> _name;
  bool _isAdvertising = false;

  @override
  void initState() {
    super.initState();
    _name = UserProvider().getUser();
    BluetoothProvider().initBeacon();
    BluetoothProvider().broadcast().getAdvertisingStateChange().listen((event) {
      setState(() {
        _isAdvertising = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerIcon = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('lib/assets/icon.png'),
        ),
      ),
    );

    final userName = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<String> (
        future: _name,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('');
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Text(
                    'Hello, ${snapshot.data} !',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                );
              }
          }
          return null;
        },
      )
    );

    final advertisingStatus = Padding(
      padding: EdgeInsets.only(top: 32.0),
      child: Text(
        'Advertising: $_isAdvertising',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      )
    );

    final uuid = Padding(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: UserProvider().getUUID(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text(
                'UUID: ',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Text(
                  'UUID: ${snapshot.data.toString()}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                );
              }
          }
          return null;
        },
      ),
    );

    final logoutButton = Padding(
      padding: EdgeInsets.zero,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          await UserProvider().signOut();
          Navigator.pushReplacementNamed(context, "/");
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Logout', style: TextStyle(color: Colors.teal)),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.teal,
          Colors.teal.shade200,
        ]),
      ),
      child: Column(
        children: <Widget>[
          headerIcon,
          userName,
          advertisingStatus,
          uuid,
          SizedBox(height: 24.0),
          logoutButton,
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
