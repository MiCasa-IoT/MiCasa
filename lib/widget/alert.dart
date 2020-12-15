import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String message) {
  Widget okButton = FlatButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text('OK')
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text("Error"),
    content: Text(message.toString()),
    actions: [okButton],
  );

  showDialog(context: context, builder: (BuildContext context) {
    return alertDialog;
  });
}