import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';

class NameTextField extends StatefulWidget {
   NameTextField({Key key, @required this.nameController}) : super(key: key);
TextEditingController nameController;
  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          onChanged: (value) => ToDoController.get(context).setNameText(value),
          // controller: widget.nameController,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: "Lato",
              color: Color(0xFF17163F)),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.005,
            width: MediaQuery.of(context).size.width - 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFE1E9A),
                  Color(0xFF254DDE),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
