import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BoldText("WALLET"))
    );
  } 
}

class ExchangeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BoldText("EXCHANGE"))
    );
  } 
}

class CryptoSaveScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BoldText("CRYPTOSAVE"))
    );
  } 
}


class MoreScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BoldText("MORE"))
    );
  } 
}

class BoldText extends StatelessWidget {
  final String text;
  BoldText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)
    );
  } 
}

