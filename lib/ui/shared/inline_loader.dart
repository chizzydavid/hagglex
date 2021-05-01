import 'package:flutter/material.dart';

class InlineLoader extends StatelessWidget {
  final double size;
  final Color color;

  InlineLoader({
    this.size = 21, 
    this.color = Colors.white,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor:AlwaysStoppedAnimation<Color>(color)
      ),
    );
  }
}
