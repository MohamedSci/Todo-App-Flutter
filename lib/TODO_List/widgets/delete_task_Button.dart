import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTaskButton extends StatefulWidget {
  DeleteTaskButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;

  @override
  State<DeleteTaskButton> createState() => _DeleteTaskButtonState();
}

class _DeleteTaskButtonState extends State<DeleteTaskButton> {
  deleteFun({
    @required int id,
  }) async {
    if (id != "" && id != null) {
      int i = await DatabaseProvider.get(context).delete(id);
      if (i != null) {
        print("One Task 0123456789 Deleted;");
        Navigator.pop(context);
      }
    } else {
      print("there is no title");
    }
  }

  reset() {
    // titleController.text = "";
    // descriptionController.text = "";
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
            onTap: () => deleteFun(
              id: todoCont.getIdNum(),
            ),
            child: Container(
                width: widget.width * 0.2,
                height: widget.height * 0.082,
                color: const Color(0xFFE30000),
                child: Center(
                  child: TextWidget(
                      color: Colors.white, fontSize: 16, txt: widget.btnTxt),
                )),
          );
        });
  }
}
