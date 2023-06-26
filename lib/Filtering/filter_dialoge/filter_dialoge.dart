import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/widgets/buttons/Filter_Radio_Button.dart';
import 'package:todo_app/TODO_List/widgets/buttons/back_task_Button.dart';
import 'package:todo_app/TODO_List/widgets/buttons/filter_confirm_Button.dart';
import 'package:todo_app/TODO_List/widgets/buttons/remove_filter_Button.dart';
import 'package:todo_app/TODO_List/widgets/color_listview.dart';
import 'package:todo_app/TODO_List/widgets/date_picker.dart';
import 'package:todo_app/TODO_List/widgets/name_txtField.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/TODO_List/widgets/time_picker.dart';
import 'package:todo_app/states/states.dart';

class FilterDialoge extends StatefulWidget {
  FilterDialoge({Key key,@required this.width, @required this.height}) : super(key: key);
double width , height;
  @override
  _FilterDialogeState createState() => _FilterDialogeState();
}

class _FilterDialogeState extends State<FilterDialoge> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) => print("Group navigator state"),
        builder: (context, state) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(68.0))),
            contentPadding: const EdgeInsets.only(top: 4.0),
            backgroundColor: kCardColor,
            elevation: 32,
            content: Container(
              width: widget.width * 0.9,
              height: widget.height * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: kBackColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0),
                ],
              ),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(children: [
                     Expanded(flex: 2,child: Align(alignment: Alignment.centerLeft,
                         child: TextWidget(fontSize: 21,color: Colors.black,txt: "Put your Filters",))),
                     Expanded(flex: 1, child:  Align(
                       alignment: Alignment.centerLeft,
                       child: TextWidget(
                           color: const Color.fromRGBO(24, 23, 67, 0.3),
                           fontSize: 13,
                           txt: "Color"),
                     )),
                     Expanded(flex: 2, child:  ColorListView(height: widget.height,width: widget.width)),
                     Expanded(flex: 1, child:  Align(
                       alignment: Alignment.centerLeft,
                       child: TextWidget(
                           color: const Color.fromRGBO(24, 23, 67, 0.3),
                           fontSize: 13,
                           txt: "Title Or Description"),
                     )),
                     Expanded(flex: 1, child: Align(
                         alignment: Alignment.centerLeft,
                         child: NameTextField())),
                     Expanded(flex: 1, child:  Align(
                       alignment: Alignment.centerLeft,
                       child: TextWidget(
                           color: const Color.fromRGBO(24, 23, 67, 0.3),
                           fontSize: 13,
                           txt: "Date"),
                     )),
                     Expanded(flex: 1, child: Align(
                         alignment: Alignment.centerLeft,
                         child: DatePickerWidget())),
                     Expanded(flex: 1, child: Align(
                       alignment: Alignment.centerLeft,
                       child: TextWidget(
                           color: const Color.fromRGBO(24, 23, 67, 0.3),
                           fontSize: 13,
                           txt: "Time"),
                     )),
                     Expanded(flex: 1, child: Align(
                         alignment: Alignment.centerLeft,
                         child: TimePickerWidget())),
                     Expanded(flex: 5 ,child: Align(
                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             // BackTaskButton(height: widget.height, width: widget.width, btnTxt: "Back"),
                             RemoveFilterButton(btnTxt: "No Filter",height: widget.height, width: widget.width),
                             FilterConfirmButton(height: widget.height, width: widget.width,btnTxt: "Filter",),

                           ],
                         )))
                   ]),
                 ),
              )

            ),
          );
        });
  }

}
