import 'package:flutter/material.dart';
import 'package:hagglex/ui/shared/screen_frame.dart';
import 'package:hagglex/ui/shared/button.dart';
import 'package:hagglex/utils/assets.dart';

class SuccessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;

    return ScreenFrame(
      useAppbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: sh * 0.13),
          Image.asset(Assets.SUCCESS_ICON, width: 70,),
          Padding(
            padding: const EdgeInsets.only(top:40.0, bottom: 20),
            child: Text(
              "Setup Complete", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
            ),
          ),

          Text("Thank you for setting up your HaggleX account", style: TextStyle(color: Colors.white, fontSize: 12),),
          SizedBox(height: sh * 0.35,),
          Button(
            "START EXPLORING",
            textColor: Color(0xff3E0606),
            onPressedAction: () {
              Navigator.pushNamedAndRemoveUntil(context, "dashboard", (route) => false);
            } 
          ),
          SizedBox(height: sh * 0.5)
        ],
      )
    );
  }

}