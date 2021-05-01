import 'package:flutter/material.dart';

class ScreenFrame extends StatelessWidget {
  final String title;
  final Widget child;
  final bool appbarTransparent;
  final Color appbarBgColor;
  final Color appbarTextColor;
  final bool implyLeading;
  final bool gradientBg;
  final bool useAppbar;

  ScreenFrame(
    {this.title,
    this.appbarTransparent = false,
    this.appbarBgColor = Colors.transparent,
    this.appbarTextColor = Colors.white,
    this.implyLeading = false,
    this.gradientBg = true,
    this.useAppbar = true,
    @required this.child});

    @override
    Widget build(BuildContext context) {
      double sh = MediaQuery.of(context).size.height;

      Widget leading = IconButton(
        padding: EdgeInsets.only(left: 5, top: 5),
        icon: Icon(Icons.chevron_left, size: 36, color: Colors.white),
        onPressed: () => Navigator.pop(context)
      );

      AppBar appBar = useAppbar 
        ? AppBar(
            backgroundColor: appbarBgColor ?? null,
            automaticallyImplyLeading: implyLeading,
            leading: leading,
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.only(left: implyLeading ? 0 : 5.0),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 22, color: appbarTextColor ?? null)
              ),
            ),
          )
        : null;

      Widget body = SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
          child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              height: sh,
              child: SingleChildScrollView(child: child)
            ),
          ),
        ),
      );

      return gradientBg
        ? Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF36226B).withOpacity(0.78),
                      Color(0xFF271260).withOpacity(0.8),
                    ],
                    stops: [
                      0.01,
                      0.42,
                    ],
                  ),
                ),

                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: appBar,
                  body: body
                ),
              ),
            )
          )

        : Scaffold(
            appBar: title != null ? appBar : null,
            body: body
          );
    }
}

