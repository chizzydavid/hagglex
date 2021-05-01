import 'package:flutter/material.dart';
import 'package:hagglex/ui/router.dart';
import 'package:hagglex/ui/screens/login.dart';
import 'package:hagglex/ui/shared/app_theme.dart';

void main() async {
  runApp(HaggleX());
}

class HaggleX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: HGRouter.generateRoute,
      home: LoginScreen()
    );
  }
}

