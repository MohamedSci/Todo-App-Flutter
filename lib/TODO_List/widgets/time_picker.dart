import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:todo_app/Filtering/filter_controller/filter_controller.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimePickerWidget extends StatefulWidget {
  TimePickerWidget({Key key}) : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  DateTime dateNow = DateTime.now();
  Time _time;
  bool iosStyle = true;
  TextEditingController timeController = TextEditingController();

  parseTime(String time) {
    if(time != null  && time != "" && time.length >= 5){
      String hours = time.substring(0, 2);
      String mins = time.toString().substring(3, 5);
      if (int.parse(hours) > 12) {
        int nightHours = int.parse(hours)  - 12;
        setState(() {
          timeController.text = "${nightHours.toString()} : $mins  PM";
        });
      } else {
        setState(() {
          timeController.text = "${hours.toString()} : $mins  AM";
        });
      }
    }
  }

  @override
  void initState() {
    _time = Time(
        hour: dateNow.hour, minute: dateNow.minute, second: dateNow.second);
    timeController.text = ToDoController.get(context).getDrawerState() == DrawerState.update?
        parseTime(ToDoController.get(context).getTimeText()):"";
    // TODO: implement initState
    super.initState();
  }

  Future<void> onTimeChanged({@required Time newTime,@required bool isFilterMode}) async {
    String vTime = newTime.toString().substring(10, 15);
    parseTime(vTime);
    isFilterMode ?
    await FilterController.get(context)
        .setTimeText(vTime)
   : await ToDoController.get(context)
        .setTimeText(vTime);
    print("isFilterMode $isFilterMode  FilterController.get(context).getTimeText}");

    print("_time _time $newTime");
  }

  @override
  void dispose() {
    timeController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(listener: (context, state) {
      print(state);
    }, builder: (context, state) {
      // ToDoController toDoController = ToDoController.get(context);
     bool isFilterMode = ToDoController.get(context).getDrawerState() == DrawerState.filter;
      print("time isFilterMode $isFilterMode");

      return Stack(
        children: [
          TextField(
            onTap: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _time,
                  sunrise: const TimeOfDay(hour: 6, minute: 0),
                  // optional
                  sunset: const TimeOfDay(hour: 18, minute: 0),
                  // optional
                  duskSpanInMinutes: 120,
                  // optional
                  onChange: (p0) => onTimeChanged(newTime: p0,isFilterMode: isFilterMode),
                ),
              );
            },
            controller: timeController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down_outlined, size: 27),
              hintText: "Pick Time",
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
    });
  }
}
