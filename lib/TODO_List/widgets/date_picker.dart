import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/states/states.dart';


class DatePickerWidget extends StatefulWidget {
   DatePickerWidget({Key key}) : super(key: key);
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          dateController.text = ToDoController.get(context).getDateText();
        return  Stack(
          children: [
            TextField(
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
                     ToDoController.get(context).setDateString(value.toString().substring(0,11));
                     print("datePicked datePicked $value");
                   }
                     );
                },
                controller: dateController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down_outlined,size: 27),
                    hintText: "Start Date",
                    hintStyle: TextStyle(color: Colors.black),
                    // isDense: true,
                    // filled: true,
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
