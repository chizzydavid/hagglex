import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF2E1963),
    accentColor: Color(0xFFFFC175),
    appBarTheme: AppBarTheme(
      color: Color(0xFFffffff),
      iconTheme: IconThemeData(
        color:  Color(0xFFEE4367),
        size: 35
      )
    ),
  );

}
