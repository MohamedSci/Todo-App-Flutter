import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/TODO_List/Screens/add_task/widgets/date_picker.dart';
import 'package:todo_app/TODO_List/Screens/add_task/widgets/time_picker.dart';
import 'package:todo_app/TODO_List/widgets/color_listview.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';

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
            // physics: const ScrollPhysics(),
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            children: [
              Expanded(flex: 1, child: TextWidget(
                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                  fontSize: 12,
                  txt: "Color")),
              Expanded(flex: 1, child:  ColorListView(height: height,width: width)),
              Expanded(flex: 1, child: TextWidget(
                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                  fontSize: 12,
                  txt: "Name")),
              Expanded(flex: 1, child: Stack(
                children: [
                  TextField(
                    controller: nameController,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Lato",
                        color: Color(0xFF17163F)),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.005,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFE1E9A),
                            Color(0xFF254DDE),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
              Expanded(flex: 1, child: TextWidget(
                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                  fontSize: 12,
                  txt: "Description")),
              Expanded(flex: 1, child: TextField(
                controller: descController,
                maxLength: 4,
                style: const TextStyle(
                    fontSize: 12, fontFamily: "Lato", color: Color(0xFF17163F)),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              )),
              Expanded(flex: 1, child:  TextWidget(
                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                  fontSize: 12,
                  txt: "Date")),
              Expanded(flex: 1, child: DatePickerWidget(dateController: dateController,)),
              Expanded(flex: 1, child: TextWidget(
                  color: const Color.fromRGBO(24, 23, 67, 0.2),
                  fontSize: 12,
                  txt: "Time")),
              Expanded(flex: 1, child: TimePickerWidget(timeController: timeController,)),
            ],
          ),
        ),
      )
    );
  }
}
