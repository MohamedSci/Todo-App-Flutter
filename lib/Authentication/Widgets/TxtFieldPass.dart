import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/Logic/authScreenProvider.dart';
import 'package:todo_app/Constants/colors.dart';

class TextFieldPass extends StatefulWidget {
  TextFieldPass({Key key,@required this.txtField}) : super(key: key);
String txtField;
  @override
  State<TextFieldPass> createState() => _TextFieldPassState();
}

class _TextFieldPassState extends State<TextFieldPass> {
  TextEditingController passController = TextEditingController();
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    passController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passController,
      keyboardType: TextInputType.text,
      onChanged: (value) =>
      AuthScreenProvider.get(context).setPassString(value),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please, ${widget.txtField}';
        }
        return null;
      },
      obscureText: !_passwordVisible,//This will obscure text dynamically
      onTap: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
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
