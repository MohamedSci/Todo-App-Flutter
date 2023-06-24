import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
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
  Widget build(BuildContext context) {
      return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          descController.text = ToDoController.get(context).getDescText();
        return TextField(
          onChanged: (value) => ToDoController.get(context).setDescString(value),
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
