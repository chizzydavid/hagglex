import 'package:flutter/material.dart';

class HGSnackBar {
  static void show (BuildContext context, String text, bool isSuccess) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('$text', style: TextStyle(color: Colors.white)),
        backgroundColor: isSuccess ? Colors.green : Colors.redAccent,
      )
    );
  }
}
