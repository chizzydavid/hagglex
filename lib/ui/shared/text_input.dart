import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HGTextInput extends StatefulWidget {

  final Widget suffixIcon;
  final Function suffixAction;
  final String errorText;
  final bool obscureText;
  final TextInputType inputType;
  final String placeholder;
  final String output;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final double bottomPadding;
  final bool isLightField;

  HGTextInput({
    this.placeholder,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.errorText,
    this.output,
    this.suffixIcon,
    this.suffixAction,
    this.controller,
    this.validator,
    this.bottomPadding = 20,
    this.isLightField = false
  });

  @override
  State<StatefulWidget> createState() => TextInputState();
}

class TextInputState extends State<HGTextInput> {
  String error;

  @override
  Widget build(BuildContext context) {
    String fieldError = error ?? widget.errorText;

    List<Widget> children = [
      TextFormField(
        style: TextStyle(fontSize: 15, color: widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040)),
        enabled: true,
        keyboardType: widget.inputType,
        controller: widget.controller,
        validator: (String val) {
          setState(() => error = widget.validator != null ? widget.validator(val) : null);
          return error;
        },
        obscureText: widget.obscureText,
        onChanged: (String val) {
          setState(() => error = null);
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          errorStyle: TextStyle(fontSize: 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040), width: 1.4)
          ),
          errorBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: error != null ? Colors.red : widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040), width: 2),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: error != null ? Colors.red : widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040), width: 1.4)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040), width: 2),
          ),

          suffixIcon: widget.suffixIcon == null
            ? null
            : InkWell(
                onTap: widget.suffixAction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: widget.suffixIcon,
                ),
              ),
          labelText: widget.placeholder,
          labelStyle: TextStyle(color: widget.isLightField ? Color(0xffe6e6e6) : Color(0xff404040), fontSize: 14)
        )
        .applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Visibility(
          visible: fieldError != null,
          child: Text(
            fieldError ?? widget.output ?? '',
            style: TextStyle(
                color: fieldError != null ? Colors.red : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
          ),
        ),
      ),
    ];
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: Column(
        children: children,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
