import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
   TextWidget({Key key, @required this.fontSize,@required this.color, @required this.txt}) : super(key: key);
double fontSize;
String txt;
Color color;
  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.txt,
      style: TextStyle(
    fontSize: widget.fontSize, fontFamily: "Lato",color: widget.color,fontWeight: FontWeight.w400
    ),);
  }
}
