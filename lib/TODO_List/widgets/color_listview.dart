import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';

class ColorListView extends StatefulWidget {
  ColorListView({Key key, @required this.height, @required this.width})
      : super(key: key);
  double height, width;

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  List<int> kListOptionsColor = [
    0xFFFF008D,
    0xFF0DC4F4,
    0xFFCF28A9,
    0xFF3D457F,
    0xFF00CF1C,
    0xFFE9DA0E
  ];

  @override
  Widget build(BuildContext context) {
    print("kListOptionsColor $kListOptionsColor");
    return SizedBox(
      width: widget.width,
      height: widget.height * 0.11,
      child:
      ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: kListOptionsColor.length,
        itemBuilder: (context, i) {
          print("kListOptionsColor i --- ${kListOptionsColor[i]}");

          return  Padding(
            padding: EdgeInsets.all(widget.width * 0.005),
            child: SizedBox(
              height: widget.height * 0.1,
              width: widget.width * 0.1,
              child: InkWell(onTap: () {

              },
                  child: CircleAvatar(backgroundColor: Color(kListOptionsColor[i]))),
            ),
          );
        },
      ),
    );
  }
}
