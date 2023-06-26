import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/TODO_List/widgets/buttons/add_task_Button.dart';
import 'package:todo_app/TODO_List/widgets/date_picker.dart';
import 'package:todo_app/TODO_List/widgets/color_listview.dart';
import 'package:todo_app/TODO_List/widgets/desc_txt_field.dart';
import 'package:todo_app/TODO_List/widgets/name_txtField.dart';
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
  // TextEditingController nameController = TextEditingController();
  // TextEditingController descController = TextEditingController();
  // static TextEditingController dateController = TextEditingController();
  // static TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: kBackColor,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 3,child: Align(alignment: Alignment.centerLeft,
                    child: TextWidget(fontSize: 21,color: Colors.black,txt: "NEW TASK",))),
                Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      color: const Color.fromRGBO(24, 23, 67, 0.3),
                      fontSize: 13,
                      txt: "Color"),
                )),
                Expanded(flex: 3, child:  ColorListView(height: height,width: width)),
                Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      color: const Color.fromRGBO(24, 23, 67, 0.3),
                      fontSize: 13,
                      txt: "Name"),
                )),
                Expanded(flex: 2, child: Align(
                    alignment: Alignment.centerLeft,
                    child: NameTextField())),
                Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      color: const Color.fromRGBO(24, 23, 67, 0.3),
                      fontSize: 13,
                      txt: "Description"),
                )),
                Expanded(flex: 5, child:Align(
                    alignment: Alignment.centerLeft,
                    child: DescTextField())),
                Expanded(flex: 2, child:  Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      color: const Color.fromRGBO(24, 23, 67, 0.3),
                      fontSize: 13,
                      txt: "Date"),
                )),
                Expanded(flex: 2, child: Align(
                    alignment: Alignment.centerLeft,
                    child: DatePickerWidget())),
                Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                      color: const Color.fromRGBO(24, 23, 67, 0.3),
                      fontSize: 13,
                      txt: "Time"),
                )),
                Expanded(flex: 2, child: Align(
                    alignment: Alignment.centerLeft,
                    child: TimePickerWidget())),
                Expanded(flex:4 ,child: Align(
                    alignment: Alignment.centerLeft,
                    child: AddTaskButton(height: height, width: width,btnTxt: "Add",)))
              ],
            ),
          ),
        ),
      )
    ;
  }
}
