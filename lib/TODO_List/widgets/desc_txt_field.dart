import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';

class DescTextField extends StatefulWidget {
  DescTextField({Key key,@required this.descController}) : super(key: key);
TextEditingController descController;
  @override
  State<DescTextField> createState() => _DescTextFieldState();
}

class _DescTextFieldState extends State<DescTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => ToDoController.get(context).setDescString(value),
      // controller: widget.descController,
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
    );
  }
}
