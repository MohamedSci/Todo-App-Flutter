import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveFilterButton extends StatefulWidget {
  RemoveFilterButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<RemoveFilterButton> createState() => _RemoveFilterButtonState();
}

class _RemoveFilterButtonState extends State<RemoveFilterButton> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
@override
void dispose() {
  // ToDoController.get(context).setDrawerState(DrawerState.insert);

  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) => print(" state"),
        builder: (context, state) {
          ToDoController todoCont = ToDoController.get(context);
          return InkWell(
            onTap: () {  todoCont.setDrawerState(DrawerState.insert);
              Navigator.pop(context);},

            child: Container(
                width: widget.width * 0.3,
                height: widget.height * 0.082,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.tealAccent,
                        Color(0xFF08D8F8),
                        Colors.teal
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32))),
                child: Center(
                  child: TextWidget(
                      color: Colors.white, fontSize: 17, txt: widget.btnTxt),
                )),
          );
        });
  }
}
