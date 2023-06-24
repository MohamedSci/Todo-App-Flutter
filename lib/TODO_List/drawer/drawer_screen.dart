import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/Screens/add_task/Add_Task.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';

class DrawerScreen extends StatefulWidget {
   DrawerScreen({Key key,@required this.state, @required this.width}) : super(key: key);
DrawerState state = DrawerState.insert;double width;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 14,width: widget.width * 0.8,
      child: widget.state == DrawerState.insert? AddTask():SizedBox(),);
  }
}
