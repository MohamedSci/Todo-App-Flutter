import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/Logic/Auth_Api.dart';
import 'package:todo_app/Authentication/Logic/authScreenProvider.dart';
import 'package:todo_app/Authentication/Screens/auth_error_dialoge.dart';
import 'package:todo_app/TODO_List/Screens/DisplayTasks/Display_Tasks.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/TODO_List/navigation_screen/Navigation_screen.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInButton extends StatefulWidget {
  LogInButton(
      {Key key,
      @required this.btnTxt,
      @required this.height,
      @required this.formKey,
      @required this.width})
      : super(key: key);
  String btnTxt;
  double width, height;
  GlobalKey<FormState> formKey;
  @override
  State<LogInButton> createState() => _LogInButtonState();
}

class _LogInButtonState extends State<LogInButton> {
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
                  onTap: () async {
                    if (widget.formKey.currentState.validate()) {
                      String mailTxt =
                          AuthScreenProvider.get(context).getMailText() ?? "";
                      String passTxt =
                          AuthScreenProvider.get(context).getPassText() ?? "";
                      print("mailTxt : $mailTxt");
                      print("passTxt : $passTxt");
                      bool isAuthenticated;
                      isAuthenticated =   await  AuthApi.get(context)
                          .getUser(mail: mailTxt, pass: passTxt);
                      print("isAuthenticated 00 $isAuthenticated");
                      if (isAuthenticated != null && isAuthenticated == true) {
                        print("isAuthenticated 01 $isAuthenticated");
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) {
                              ToDoController.get(context).setDrawerState(DrawerState.insert);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavigationScreen()),
                                );});
                      } else {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AuthErrorDialoge());
                      }
                    }
                  },
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
                        child: Text(
                          widget.btnTxt,
                          style: const TextStyle(
                              fontSize: 21,
                              fontFamily: "Lato",
                              color: Colors.white),
                        ),
                      )),
                );
              });
        });
  }
}
