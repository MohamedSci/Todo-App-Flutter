import 'package:flutter/material.dart';

class MainTextAuth extends StatefulWidget {
  MainTextAuth({Key key,@required this.txt}) : super(key: key);
String txt;
  @override
  State<MainTextAuth> createState() => _MainTextAuthState();
}

class _MainTextAuthState extends State<MainTextAuth> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.txt,style: const TextStyle(
      fontSize: 32, fontFamily: "Lato"
    ),);
  }
}
