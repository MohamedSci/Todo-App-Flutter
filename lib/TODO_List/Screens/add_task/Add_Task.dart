import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/TODO_List/widgets/date_picker.dart';
import 'package:todo_app/TODO_List/widgets/color_listview.dart';
import 'package:todo_app/TODO_List/widgets/desc_txt_field.dart';
import 'package:todo_app/TODO_List/widgets/name_txtField.dart';
import 'package:todo_app/TODO_List/widgets/task_Button.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/TODO_List/widgets/time_picker.dart';

class AddTask extends StatefulWidget {
  const AddTask({
    Key key,
  }) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  static TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: kBackColor,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // physics: const ScrollPhysics(),
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            children: [
              Expanded(flex: 2, child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    color: const Color.fromRGBO(24, 23, 67, 0.2),
                    fontSize: 12,
                    txt: "Color"),
              )),
              Expanded(flex: 5, child:  ColorListView(height: height,width: width)),
              Expanded(flex: 2, child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    color: const Color.fromRGBO(24, 23, 67, 0.2),
                    fontSize: 12,
                    txt: "Name"),
              )),
              Expanded(flex: 3, child: Align(
                  alignment: Alignment.centerLeft,
                  child: NameTextField(nameController: nameController,))),
              Expanded(flex: 2, child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    color: const Color.fromRGBO(24, 23, 67, 0.2),
                    fontSize: 12,
                    txt: "Description"),
              )),
              Expanded(flex: 5, child:Align(
                  alignment: Alignment.centerLeft,
                  child: DescTextField(descController: descController,))),
              Expanded(flex: 2, child:  Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    color: const Color.fromRGBO(24, 23, 67, 0.2),
                    fontSize: 12,
                    txt: "Date"),
              )),
              Expanded(flex: 3, child: Align(
                  alignment: Alignment.centerLeft,
                  child: DatePickerWidget(dateController: dateController,))),
              Expanded(flex: 2, child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    color: const Color.fromRGBO(24, 23, 67, 0.2),
                    fontSize: 12,
                    txt: "Time"),
              )),
              Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerLeft,
                  child: TimePickerWidget(timeController: timeController,))),
              Expanded(flex:4 ,child: Align(
                  alignment: Alignment.centerLeft,
                  child: TaskButton(height: height, width: width,btnTxt: "Add",)))
            ],
          ),
        ),
      )
    );
  }
}
