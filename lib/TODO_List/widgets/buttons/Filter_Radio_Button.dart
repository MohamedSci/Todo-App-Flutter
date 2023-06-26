import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterRadioButton extends StatefulWidget {
  FilterRadioButton(
      {Key key,
      @required this.height,
      @required this.width})
      : super(key: key);
  double width, height;

  @override
  State<FilterRadioButton> createState() => _FilterRadioButtonState();
}

class _FilterRadioButtonState extends State<FilterRadioButton> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseProvider, ChangState>(
        listener: (context, state) => print(" state"),
        builder: (context, state) {
          DatabaseProvider provider = DatabaseProvider.get(context);
          return Container(
              width: widget.width * 0.3,
              height: widget.height * 0.013,
              child: Stack(
                 children: [
                   Checkbox(
                     value: provider.getFilterIsJoined(),
                     onChanged: (bool value) {
                       provider.setFilterIsJoined(value);
                     },
                   ),
                   const Align(alignment: Alignment.topRight,
                       child: Text('Bound',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500))),

                 ],
                  ));
        });
  }
}
