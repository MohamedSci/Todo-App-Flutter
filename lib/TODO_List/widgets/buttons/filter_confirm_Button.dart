import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterConfirmButton extends StatefulWidget {
  FilterConfirmButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<FilterConfirmButton> createState() => _FilterConfirmButtonState();
}

class _FilterConfirmButtonState extends State<FilterConfirmButton> {
  filterFun(
      {
        @required int color,
      @required String name,
      @required String date,
      @required String time}) async {
     await DatabaseProvider.get(context).filterTasks(
       color: color,nameDesc: name,date: date ,time: time
     );
  }


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
            onTap: () => filterFun(
              color: todoCont.getColorNum(),
              name: todoCont.getNameText(),
              date: todoCont.getDateText(),
              time: todoCont.getTimeText(),
            ),
            child: Container(
                width: widget.width * 0.4,
                height: widget.height * 0.082,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF254DDE),
                        Color(0xFF1988E9),
                        Color(0xFF08D8F8)
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
