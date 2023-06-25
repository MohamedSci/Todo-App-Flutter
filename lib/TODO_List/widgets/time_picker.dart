import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerWidget extends StatefulWidget {
   TimePickerWidget({Key key}) : super(key: key);
  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
DateTime dateNow = DateTime.now();
  Time _time ;
  bool iosStyle = true;
TextEditingController timeController= TextEditingController();

  @override
  void initState() {
     _time = Time(hour: dateNow.hour, minute: dateNow.minute, second: dateNow.second);

    // TODO: implement initState
    super.initState();
  }
  Future<void> onTimeChanged(Time newTime) async {
    await ToDoController.get(context).setTimeText(newTime.toString().substring(10,15));
    print("_time _time $newTime");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          timeController.text = ToDoController.get(context).getTimeText();
        return Stack(
          children: [
            TextField(
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
              controller: timeController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_outlined,size: 27),
                  hintText: "Start Date",
                  hintStyle: TextStyle(color: Colors.black),
                  // isDense: true,
                  // filled: true,
                  // fillColor: kCardColor
              ),
            ),
            Positioned(
              bottom: -1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.002,
                width: MediaQuery.of(context).size.width - 20,
                decoration: const BoxDecoration(
                  color: Color(0xFF181743),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),

                ),
              ),
            )

          ],
        );
      }
    );
  }
}
