import 'package:flutter/material.dart';

class TextAuth extends StatefulWidget {
  TextAuth({Key key,@required this.txt}) : super(key: key);
String txt;
  @override
  State<TextAuth> createState() => _TextAuthState();
}

class _TextAuthState extends State<TextAuth> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(widget.txt,
        textAlign: TextAlign.left,
        style: const TextStyle(
        fontSize: 14, fontFamily: "Lato"
      ),),
    );
  }
}
