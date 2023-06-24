import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';

class DatePickerWidget extends StatefulWidget {
   DatePickerWidget({Key key,@required this.dateController}) : super(key: key);
TextEditingController dateController;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: TextField(
        onTap: () async {
           await DatePicker.showSimpleDatePicker(
            context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2030),
            dateFormat: "dd-MMMM-yyyy",
            locale: DateTimePickerLocale.en_us,
            looping: true,
          ).then((value) {
             ToDoController.get(context).setDateString(value.toIso8601String());
             print("datePicked datePicked $value");
           }
             );


        },
        // controller: widget.dateController,
        style: const TextStyle(color: kBackColor),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.arrow_drop_down_outlined),
            hintText: "Start Date",
            hintStyle: TextStyle(color: kButtonColor),
            isDense: true,
            filled: true,
            fillColor: kCardColor),
      ),
    );
  }
}
