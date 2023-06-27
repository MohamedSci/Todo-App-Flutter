import 'package:flutter/material.dart';
import 'package:todo_app/Filtering/filter_controller/filter_controller.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescTextField extends StatefulWidget {
  DescTextField({Key key,}) : super(key: key);
  @override
  State<DescTextField> createState() => _DescTextFieldState();
}

class _DescTextFieldState extends State<DescTextField> {
  TextEditingController descController = TextEditingController();

  @override
void initState() {
  descController.text = ToDoController.get(context).getDrawerState() == DrawerState.update?
      ToDoController.get(context).getDescText():"";
  // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    descController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          // ToDoController toDoController = ToDoController.get(context);
          // FilterController filterController = FilterController.get(context);
         bool isFilterMode = ToDoController.get(context).getDrawerState() == DrawerState.filter;
          print("desc isFilterMode $isFilterMode");

          return TextField(
          onChanged: (value) => isFilterMode ?
          FilterController.get(context).setDescString(value):
          ToDoController.get(context).setDescString(value),
          controller: descController,
          maxLines: 4,
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
        );
      }
    );
  }
}
