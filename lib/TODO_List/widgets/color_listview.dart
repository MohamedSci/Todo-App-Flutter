import 'package:flutter/material.dart';
import 'package:todo_app/Filtering/filter_controller/filter_controller.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
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
bool isFilterMode = false;
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
    return BlocConsumer<FilterController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          return BlocConsumer<ToDoController, ChangState>(
            listener: (context, state) {
              print(state);
            },
            builder: (context, state) {
              ToDoController toDoController = ToDoController.get(context);
              FilterController filterController = FilterController.get(context);
             isFilterMode = toDoController.getDrawerState() == DrawerState.filter;
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
               bool isSelected =   isFilterMode?
               filterController.getColorNum() == kListOptionsColor[i]
                      :toDoController.getColorNum() == kListOptionsColor[i];

                  print("kListOptionsColor i --- ${kListOptionsColor[i]}");
                  return  Container(
                    margin: const EdgeInsets.all(1.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration:
                    isSelected?
                    BoxDecoration(
                        border: Border.all(color: Color(kListOptionsColor[i]))
                    ):null,
                    height: widget.height * 0.10,
                    width: widget.width * 0.12,
                    child: InkWell(
                        onTap: () {
                          isFilterMode ?
                  FilterController.get(context).setColorNum(kListOptionsColor[i]):
                  toDoController.setColorNum(kListOptionsColor[i]);
                          setState(() {
                            isChoosed = true;
                          });
                        },
                        child: CircleAvatar(backgroundColor: Color(kListOptionsColor[i]),
                          radius: 32,)),
                  );
                },
              ),
            );
          }
        );
      }
    );
  }
}
