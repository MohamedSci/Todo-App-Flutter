import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackTaskButton extends StatefulWidget {
  BackTaskButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<BackTaskButton> createState() => _BackTaskButtonState();
}

class _BackTaskButtonState extends State<BackTaskButton> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) => print(" state"),
        builder: (context, state) {
          ToDoController todoCont = ToDoController.get(context);
          return InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
                width: widget.width * 0.3,
                height: widget.height * 0.082,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF008D),
                    borderRadius: BorderRadius.all(Radius.circular(32))),
                child: Center(
                  child: TextWidget(
                      color: Colors.white, fontSize: 17, txt: widget.btnTxt),
                )),
          );
        });
  }
}
