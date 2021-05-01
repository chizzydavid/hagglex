import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function onPressedAction;
  final Widget child;
  final bool isGradientBg;
  final Color textColor;

  Button(
    this.label,
    {this.onPressedAction,
    this.child,
    this.textColor = Colors.white,
    this.isGradientBg = false}
  ) : super();

  @override
  Widget build(BuildContext context) {
    Text text = Text(label, style: TextStyle(fontSize: 15), textAlign: TextAlign.center,);

    return ButtonTheme.fromButtonThemeData(
      data: Theme.of(context).buttonTheme.copyWith(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: isGradientBg 
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF432B7B),
                  Color(0xFF6A4BBC),
                ],
                stops: [
                  0.4,
                  0.8
                ],
              )
            : null,
        ),
        child: RaisedButton(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          onPressed: onPressedAction,
          textColor: textColor,
          elevation: 0,
          color: isGradientBg ? Colors.transparent : Color(0xffFFC175),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              child != null ? child : text,
            ],
          ),
        ),
      )
      );
  }
}

