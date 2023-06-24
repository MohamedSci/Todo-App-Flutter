import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

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
          var datePicked = await DatePicker.showSimpleDatePicker(
            context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1960),
            lastDate: DateTime(2012),
            dateFormat: "dd-MMMM-yyyy",
            locale: DateTimePickerLocale.th,
            looping: true,
          );
          print("datePicked datePicked $datePicked");

        },
        controller: widget.dateController,
        style: const TextStyle(color: kBackColor),
        decoration: const InputDecoration(
            hintText: "Start Date",
            hintStyle: TextStyle(color: kButtonColor),
            isDense: true,
            filled: true,
            fillColor: kCardColor),
      ),
    );
  }
}
