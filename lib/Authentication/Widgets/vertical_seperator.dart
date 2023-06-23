import 'package:flutter/material.dart';

class VerticalSeperator extends StatefulWidget {
VerticalSeperator({Key key,@required this.height,@required this.width}) : super(key: key);
double height , width;

  @override
  State<VerticalSeperator> createState() => _VerticalSeperatorState();
}

class _VerticalSeperatorState extends State<VerticalSeperator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height * 0.025,
    );
  }
}

