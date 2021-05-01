import 'package:flutter/material.dart';
import 'package:hagglex/core/services/auth_client.dart';
import 'package:hagglex/ui/shared/button.dart';
import 'package:hagglex/ui/shared/inline_loader.dart';
import 'package:hagglex/ui/shared/screen_frame.dart';
import 'package:hagglex/ui/shared/show_snackbar.dart';
import 'package:hagglex/ui/shared/text_input.dart';
import 'package:hagglex/utils/validators/auth_validator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen() : super();

  @override
  Login createState() => Login();
}

class Login extends State<LoginScreen> {
  
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double sh;
  double sw;
  bool showPassword = false;
  bool isLoading = false;
  AuthValidators validator = AuthValidators();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    sw = MediaQuery.of(context).size.width;

    return ScreenFrame(
      child: Form(
         key: formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: sh * 0.1, bottom: 30),
              child: Text(
                "Welcome!", 
                style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold)
              ),
            ),

            HGTextInput(
              placeholder: 'Your email address',
              controller: emailController,
              isLightField: true,
              validator: validator.email,
            ),
            SizedBox(height: 20,),

            HGTextInput(
              placeholder: 'Password (Min 8 characters)',
              obscureText: !showPassword,
              controller: passwordController,
              suffixIcon: Icon(
                showPassword ? MdiIcons.eye : MdiIcons.eyeOff,
                size: 24.0,
                color: Colors.white
              ),
              suffixAction: () => setState(() => showPassword = !showPassword),
              isLightField: true,
              validator: validator.password,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text("Forgot Password?",
                style: TextStyle(color: Colors.white, fontSize: 14),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom : 10),
              child: Builder( 
                builder: (BuildContext context) {
                  return Button(
                    "LOG IN",
                    child: isLoading ? InlineLoader() : null,
                    textColor: Color(0xff3E0606),
                    onPressedAction: () {
                      if (formKey.currentState.validate() && !isLoading) {
                        loginUser(context);
                      }
                    } 
                  );
                }
              ),
            ),

            InkWell(
              onTap: () => Navigator.pushNamed(context, "signup"),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text:  TextSpan(
                      text: 'New User?  ',
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan> [
                        TextSpan(text: 'Create a new account')
                      ],
                      
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
          ]),
       ));
  }

  Future<void> loginUser(BuildContext context) async {
    setState(() => isLoading = true);
    dynamic result = await AuthClient().loginUser({
      'email': emailController.text,
      'password': passwordController.text
    });
    setState(() => isLoading = false);

    if (result is String) {
      HGSnackBar.show(context, result, false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'dashboard', (route) => false);
    }
  }

}



