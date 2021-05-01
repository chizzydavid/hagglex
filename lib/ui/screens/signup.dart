import 'package:flutter/material.dart';
import 'package:hagglex/core/models/user_model.dart';
import 'package:hagglex/ui/screens/verify.dart';
import 'package:hagglex/ui/shared/button.dart';
import 'package:hagglex/ui/shared/inline_loader.dart';
import 'package:hagglex/ui/shared/screen_frame.dart';
import 'package:hagglex/ui/shared/text_input.dart';
import 'package:hagglex/utils/validators/auth_validator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:hagglex/core/services/auth_client.dart';
import 'package:hagglex/ui/shared/show_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen() : super();

  @override
  SignUp createState() => SignUp();
}

class SignUp extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  AuthValidators validator = AuthValidators();

  String dialCode;
  String country;
  double sh;
  double sw;
  bool showPassword = false;
  bool isLoading = false;

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
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Form(
               key: formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create a new account", 
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 10,),

                  HGTextInput(
                    placeholder: 'Your email address',
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: validator.email,
                  ),

                  HGTextInput(
                    placeholder: 'Password (Min 8 characters)',
                    obscureText: !showPassword,
                    controller: passwordController,
                    suffixIcon: Icon(
                      showPassword ? MdiIcons.eye : MdiIcons.eyeOff,
                      size: 24.0,
                      color: Color(0xff404040)
                    ),
                    suffixAction: () => setState(() => showPassword = !showPassword),
                    validator: validator.password,
                  ),

                  HGTextInput(
                    placeholder: 'Create a username',
                    controller: userNameController,
                    validator: validator.isEmpty,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xfff1f1f1),
                            border: Border.all(width: 1, color: Color(0xff737373))
                          ),
                          width: 100,
                            child: CountryCodePicker(
                              initialSelection: '+234',
                              onChanged: (CountryCode code) {
                                setState(() {
                                  country = code.name;
                                  dialCode = code.dialCode;
                                });
                              },
                              onInit: (code) {
                                country = code.name;
                                dialCode = code.dialCode;
                              }, 
                              flagWidth: 20,
                              closeIcon: const Icon(Icons.close, color: Colors.white,),
                              dialogBackgroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              dialogTextStyle: TextStyle(color: Colors.white),
                              searchStyle: TextStyle(color: Colors.white),
                              searchDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Color(0xffe6e6e6))
                                ),
                                focusedBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffe6e6e6) ),
                                ),
                              ),
                            ),
                        ),
                        SizedBox(width: 10,),

                        Expanded(
                          child:  HGTextInput(
                            placeholder: 'Enter your phone number',
                            controller: mobileNumController,
                            inputType: TextInputType.phone,
                            validator: validator.isNumeral,
                            bottomPadding: 0,
                          ),
                        ),
                      ]
                    ),
                  ),

                  HGTextInput(
                    placeholder: 'Referral code optional',
                    controller: referralController,
                    validator: null,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Text("By signing, you agree to HaggleX terms and privacy policy",
                    style: TextStyle(fontSize: 12),),
                  ),

                  Builder( 
                    builder: (BuildContext context) {
                      return Button(
                        "SIGN UP",
                        child: isLoading ? InlineLoader() : null,
                          isGradientBg: true,
                          onPressedAction: () {
                          if (formKey.currentState.validate() && !isLoading) {
                              registerUser(context);
                            }
                          } 
                      );
                    }
                  ),

                ]),
             )),
          SizedBox(height: 40)
        ],
      )
    );
  }


  Future<void> registerUser(BuildContext context) async {
    setState(() => isLoading = true);
    dynamic result = await AuthClient().registerUser({
      'email': emailController.text,
      'password': passwordController.text,
      'username': userNameController.text,
      'phoneNumber': mobileNumController.text,
      'referralCode': referralController.text,
      'dialCode': dialCode,
      'country': country,
    });
    setState(() => isLoading = false);

    if (result is String) {
      HGSnackBar.show(context, result, false);
    } else {
      Navigator.pushNamed(context, 'verify', arguments: VerifyScreenArgs(result as User));
    }
  }

}
