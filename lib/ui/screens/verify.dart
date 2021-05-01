import 'package:flutter/material.dart';
import 'package:hagglex/core/models/error_model.dart';
import 'package:hagglex/core/models/user_model.dart';
import 'package:hagglex/core/services/auth_client.dart';
import 'package:hagglex/ui/shared/screen_frame.dart';
import 'package:hagglex/ui/shared/show_snackbar.dart';
import 'package:hagglex/ui/shared/text_input.dart';
import 'package:hagglex/ui/shared/button.dart';
import 'package:hagglex/ui/shared/inline_loader.dart';
import 'package:hagglex/utils/assets.dart';
import 'package:hagglex/utils/validators/auth_validator.dart';


class VerifyScreen extends StatefulWidget {
  final User user;
  VerifyScreen(this.user) : super();

  @override
  Verify createState() => Verify();
}

class Verify extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();
  double sh;
  double sw;
  bool isLoading = false;
  bool isResendingCode = false;
  TextEditingController codeCtrl = TextEditingController();
  AuthClient authClent = AuthClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sh = MediaQuery.of(context).size.height;
    sw = MediaQuery.of(context).size.width;

    return ScreenFrame(
      useAppbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Verify your account", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: sh * 0.07),
            padding: EdgeInsets.symmetric(vertical: sh * 0.08, horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                width: double.infinity,
            child: Form(
               key: formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.VERIFIED_ICON,
                    width: 70,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28.0),
                    child: Text("We just sent a verification code to your email. \n Please enter the code", textAlign: TextAlign.center,),
                  ),

                  HGTextInput(
                    placeholder: 'Verification Code',
                    inputType: TextInputType.number,
                    controller: codeCtrl,
                    validator: AuthValidators().isNumeral,
                  ),

                  Builder( 
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Button(
                            "VERIFY ME",
                            child: isLoading ? InlineLoader() : null,
                            isGradientBg: true,
                            onPressedAction: () {
                              if (formKey.currentState.validate() && !isLoading) {
                                verifyCode(context);
                              }
                            }
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Text("This code would expire in 10minutes",
                            style: TextStyle(fontSize: 12),),
                          ),

                          InkWell(
                            onTap: () {
                              if (!isResendingCode)
                              resendCode(context);
                            },
                            child: isResendingCode
                              ? InlineLoader(size: 12, color: Theme.of(context).primaryColor)
                              : Text(
                                'Resend Code',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                            ),
                        ]);
                    }),
                ]),
             ))
        ],
      )
    );
  }

  Future<void> verifyCode(BuildContext context) async {
    setState(() => isLoading = true);
    dynamic result = await authClent.verifyUser(int.parse(codeCtrl.text));
    setState(() => isLoading = false);

    if (result is String) {
      HGSnackBar.show(context, result, false);
      return;
    }
    Navigator.pushNamed(context, 'success');
  }

  Future<void> resendCode(BuildContext context) async {
    setState(() => isResendingCode = true);
    dynamic result = await authClent.resendCode(widget.user.email);
    setState(() => isResendingCode = false);

    if (result is ErrorModel) {
      HGSnackBar.show(context, result.error, false);
      return;
    } 
    HGSnackBar.show(context, result, true);
  }
}


class VerifyScreenArgs {
  final User user;
  VerifyScreenArgs(this.user);
}

