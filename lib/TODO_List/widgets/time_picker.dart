import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';

class TimePickerWidget extends StatefulWidget {
   TimePickerWidget({Key key,@required this.timeController}) : super(key: key);
TextEditingController timeController;
  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
DateTime dateNow = DateTime.now();
  Time _time ;
  bool iosStyle = true;

  @override
  void initState() {
     _time = Time(hour: dateNow.hour, minute: dateNow.minute, second: dateNow.second);

    // TODO: implement initState
    super.initState();
  }
  Future<void> onTimeChanged(Time newTime) async {
    await ToDoController.get(context).setNameText(newTime.toString());
    print("_time _time $newTime");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: TextField(
        onTap: () {
          Navigator.of(context).push(
            showPicker(
              context: context,
              value: _time,
              sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
              sunset: const TimeOfDay(hour: 18, minute: 0), // optional
              duskSpanInMinutes: 120, // optional
              onChange: onTimeChanged,
            ),
          );
        },
        // controller: widget.timeController,
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
