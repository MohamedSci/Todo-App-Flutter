import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Filtering/filter_screen/filter_screen.dart';
import 'package:todo_app/TODO_List/Screens/DisplayTasks/Display_Tasks.dart';

import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/states/states.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool isFilterMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          ToDoController toDoController = ToDoController.get(context);
          isFilterMode = toDoController.getDrawerState() == DrawerState.filter;
        return isFilterMode ? FilterScreen() : DisplayingTasks();
      }
    );
  }
}
