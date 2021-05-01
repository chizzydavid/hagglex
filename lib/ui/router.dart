import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hagglex/ui/screens/dashboard.dart';
import 'package:hagglex/ui/screens/login.dart';
import 'package:hagglex/ui/screens/signup.dart';
import 'package:hagglex/ui/screens/success.dart';
import 'package:hagglex/ui/screens/verify.dart';

class HGRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);

      case 'signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen(), settings: settings);

      case 'verify':
        final VerifyScreenArgs args = arguments;
        return MaterialPageRoute(builder: (_) => VerifyScreen(args.user), settings: settings);

      case 'success':
        return MaterialPageRoute(builder: (_) => SuccessScreen(), settings: settings);        

      case 'dashboard':
        return MaterialPageRoute(builder: (_) => DashboardScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: 
            Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          )
        );
    }
  }
}
