import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/Screens/add_task/Add_Task.dart';
import 'package:todo_app/TODO_List/Screens/update_tasks/Update_Task.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DrawerScreen extends StatefulWidget {
   DrawerScreen({Key key,@required this.state, @required this.width}) : super(key: key);
DrawerState state = DrawerState.insert;double width;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ToDoController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          ToDoController toDoContInstance =ToDoController.get(context);
        return Drawer(elevation: 14,width: widget.width * 0.8,
          child: toDoContInstance.getDrawerState() == DrawerState.insert? const AddTask():
          toDoContInstance.drawerState == DrawerState.update?
          UpdateTask():const SizedBox(),);
      }
    );
  }
}
