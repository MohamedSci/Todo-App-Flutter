import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTaskButton extends StatefulWidget {
  UpdateTaskButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<UpdateTaskButton> createState() => _UpdateTaskButtonState();
}

class _UpdateTaskButtonState extends State<UpdateTaskButton> {
  updateFun(
      {@required int id,
        @required int color,
      @required String name,
      @required String desc,
      @required String date,
      @required String time}) async {
    if (name != "") {
      TaskModel updateTask = TaskModel(id: id,
          color: color, title: name, description: desc, date: date, time: time
          );
      print("One Task module is created");
     int i = await DatabaseProvider.get(context).update(updateTask);
     if(i != null){
       print("id: $id , color :$color , name : $name , desc : $desc , date : $date , time : $time");
      print("One Task 0123456789 Update;");
      Navigator.pop(context);}
    } else {
      print("there is no title");
    }
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
            onTap: () => updateFun(
              id: todoCont.getIdNum(),
              color: todoCont.getColorNum(),
              name: todoCont.getNameText(),
              desc: todoCont.getDescText(),
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
