import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Constants/functions.dart';
import 'package:todo_app/Notification/notification_services.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskButton extends StatefulWidget {
  AddTaskButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  OnSave(
      {@required int color,
      @required String name,
      @required String desc,
      @required String date,
      @required String time}) async {
    if (name.isNotEmpty) {
      int id = generateRandomNumber();
      TaskModel insertTask = TaskModel(
        id: id,
          color: color, title: name, description: desc, date: date, time: time
          );
      print("One Task module is created");
     int i = await DatabaseProvider.get(context).insert(insertTask);
     if(i != null && date != null && date.length >= 10 && time.length >= 5){
       //the Notification's date
       final execDate = DateTime(int.parse(date.substring(0,4).toString()), int.parse(date.substring(5,7).toString()),
           int.parse(date.substring(8,10).toString()),int.parse(time.substring(0,2).toString()),int.parse(time.substring(3,5).toString()));
       final creationDate = DateTime.now();
       final minDiff = minutesBetween(creationDate , execDate);

       NotificationService notificationService = NotificationService();
       notificationService.showNotification(id, name, desc, minDiff).then((value) =>  Navigator.pop(context));


     }
    } else {
      Fluttertoast.showToast(
          msg: "You have to input a title !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);

      print("there is no title");
    }
  }

  reset() {
ToDoController.get(context).setColorNum(0);
ToDoController.get(context).setNameText("");
ToDoController.get(context).setDescString("");
ToDoController.get(context).setDateString("");
ToDoController.get(context).setTimeText("");

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
            onTap: () => OnSave(
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
