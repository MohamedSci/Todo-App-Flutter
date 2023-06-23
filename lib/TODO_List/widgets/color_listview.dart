import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';

class ColorListView extends StatefulWidget {
   ColorListView({Key key}) : super(key: key);
  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.top,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: kListOptionsColor.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {

            },
            child: CircleAvatar(
              backgroundColor: Color(kListOptionsColor[i]),
              radius: 28,
            ),
          );
        },
      ),
    );
  }
}
