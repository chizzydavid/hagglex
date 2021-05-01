import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeNavIcon extends StatelessWidget {
  final String icon;
  final bool active;

  const HomeNavIcon(this.icon, this.active);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        icon,
        height: 24,
        color: active ? Color(0xFF2E1963) : Color(0xffC4C4C4),
      );
  }
}

