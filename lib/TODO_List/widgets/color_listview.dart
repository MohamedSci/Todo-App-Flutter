import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ColorListView extends StatefulWidget {
  ColorListView({Key key, @required this.height, @required this.width})
      : super(key: key);
  double height, width;

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {

  bool isChoosed = false;
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
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
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
                child: Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: ToDoController.get(context).getColorNum()==kListOptionsColor[i]?
                  BoxDecoration(
                      border: Border.all(color: Color(kListOptionsColor[i]))
                  ):null,
                  height: widget.height * 0.12,
                  width: widget.width * 0.12,
                  child: InkWell(
                      onTap: () {
                        ToDoController.get(context).setColorNum(kListOptionsColor[i]);
                        setState(() {
                          isChoosed = true;
                        });
                      },
                      child: CircleAvatar(backgroundColor: Color(kListOptionsColor[i]),
                        radius: 32,)),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
