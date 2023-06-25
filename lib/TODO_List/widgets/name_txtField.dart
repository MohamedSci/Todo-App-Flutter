import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/states/states.dart';

class NameTextField extends StatefulWidget {
   NameTextField({Key key,}) : super(key: key);
  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          nameController.text = ToDoController.get(context).getNameText();
        return Stack(
          children: [
            TextField(
              onChanged: (value) => ToDoController.get(context).setNameText(value),
              controller: nameController,
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
                height: MediaQuery.of(context).size.height * 0.004,
                width: MediaQuery.of(context).size.width - 20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF254DDE),
                      Color(0xFFFE1E9A),
                    ],
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
