
import 'package:flutter/material.dart';

bool isNumber(String s) {
  if(s.isEmpty) 
    return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void showError(BuildContext context, String message, String title){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}