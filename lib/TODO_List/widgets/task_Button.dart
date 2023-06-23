import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/Logic/Auth_Api.dart';
import 'package:todo_app/Authentication/Logic/authScreenProvider.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskButton extends StatefulWidget {
  TaskButton(
      {Key key,
        @required this.btnTxt,
        @required this.height,
        @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;
  @override
  State<TaskButton> createState() => _TaskButtonState();
}

class _TaskButtonState extends State<TaskButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthApi, ChangState>(
        listener: (context, state) => print(" state"),
        builder: (context, state) {
          return BlocConsumer<AuthScreenProvider, ChangState>(
              listener: (context, state) => print(" state"),
              builder: (context, state) {
                return InkWell(
                  onTap: (){},
                  child: Container(
                      width: widget.width,
                      height: widget.height * 0.082,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xFF254DDE),
                              Color(0xFF1988E9),
                              Color(0xFF08D8F8)
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      child: Center(
                        child:
                        TextWidget(color: Colors.white,fontSize: 16,txt: widget.btnTxt),

                      )),
                );
              });
        });
  }
}
