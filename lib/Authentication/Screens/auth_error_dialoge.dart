import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';

class AuthErrorDialoge extends StatefulWidget {

  AuthErrorDialoge();

  @override
  _AuthErrorDialogeState createState() => _AuthErrorDialogeState();
}

class _AuthErrorDialogeState extends State<AuthErrorDialoge> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: kBackColor,
          elevation: 16,
          title: const Text(
            "Authentication Failed",
            style: TextStyle(color: Colors.amber),
          ),
          content: const Text(
            'Please, Check The Connection, Email and Password!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: kTitleColor, fontWeight: FontWeight.w800),
          ),
          actions: [
            ElevatedButton.icon(
              label: const Text(
                'Try Again',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: kTitleColor,
                    fontWeight: FontWeight.w800),
              ),
              icon: const Icon(Icons.replay, size: 32, color:kButtonColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
