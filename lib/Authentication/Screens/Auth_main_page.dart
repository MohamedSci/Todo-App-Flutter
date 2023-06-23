import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/Widgets/MainTextLabelAuth.dart';
import 'package:todo_app/Authentication/Widgets/TextLabelAuth.dart';
import 'package:todo_app/Authentication/Widgets/TxtFieldMail.dart';
import 'package:todo_app/Authentication/Widgets/TxtFieldPass.dart';
import 'package:todo_app/Authentication/Widgets/logIn_Btn.dart';
import 'package:todo_app/Authentication/Widgets/myPainter.dart';
import 'package:todo_app/Authentication/Widgets/vertical_seperator.dart';

class AuthMainScreen extends StatefulWidget {
  const AuthMainScreen({Key key}) : super(key: key);

  @override
  State<AuthMainScreen> createState() => _AuthMainScreenState();
}
final formKey = GlobalKey<FormState>();

class _AuthMainScreenState extends State<AuthMainScreen> {
  double height,
      width = 0.000;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: MyPainter(),
          size:  Size(width, height),
          child: SizedBox(
            height: height,
            width: width,
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                SizedBox(width: width, height: height * 0.2,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: MainTextAuth(txt: "Login",),
                        ))),
                Container(
                    width: width, height: height * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(
                        //   color: Colors.red[500],
                        // ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.2,
                      right: width * 0.05,left: width * 0.05),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          VerticalSeperator(height: height,width: width,),
                          VerticalSeperator(height: height,width: width,),
                          TextAuth(txt: "Email *"),
                          VerticalSeperator(height: height,width: width,),
                          TextFieldMail(txtField: "Enter your email"),
                          VerticalSeperator(height: height,width: width,),
                          TextAuth(txt: "Password *"),
                          VerticalSeperator(height: height,width: width,),
                          TextFieldPass(txtField: "Enter your Password"),
                          VerticalSeperator(height: height,width: width,),
                          LogInButton(btnTxt: "Sign In",height: height,width: width,),
                          VerticalSeperator(height: height,width: width,),

                        ],),
                    )),

              ]),
            ),
          ),
        ),
      ),
    );
  }
}
