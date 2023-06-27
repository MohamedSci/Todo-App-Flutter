import 'package:flutter/material.dart';

class DefaultNoData extends StatefulWidget {
  const DefaultNoData({Key key}) : super(key: key);

  @override
  State<DefaultNoData> createState() => _DefaultNoDataState();
}

class _DefaultNoDataState extends State<DefaultNoData> {
  @override
  Widget build(BuildContext context) {
    return Center(
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
    backgroundColor: const Color(0xAFFFB8F2),
    radius: 60,
    child: Image.asset("assets/images/no_data.jpg",
    fit: BoxFit.contain),
    ),
    ));
  }
}
