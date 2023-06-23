import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/Logic/authScreenProvider.dart';
import 'package:todo_app/Constants/colors.dart';

class TextFieldMail extends StatefulWidget {
  TextFieldMail({Key key,@required this.txtField}) : super(key: key);
String txtField;
  @override
  State<TextFieldMail> createState() => _TextFieldMailState();
}

class _TextFieldMailState extends State<TextFieldMail> {
  TextEditingController mailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mailController,
      keyboardType: TextInputType.emailAddress,

      onChanged:(value) =>
          AuthScreenProvider.get(context).setMailText(value),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please, ${widget.txtField}';
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800],
              fontSize: 14, fontFamily: "Lato"),
          hintText: widget.txtField,
          fillColor: kAuthTxtFieldColor),
    );
  }
}
