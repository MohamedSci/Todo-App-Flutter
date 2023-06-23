import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthApi extends Cubit<ChangState> {
  AuthApi() : super(InitialState());

  static AuthApi get(context) => BlocProvider.of(context);



  String token = "";

  setToken(String t) {
    token = t;
    emit(SetTokenState());
  }

  getToken() {
    return token;
  }

  Future<bool> postRequest(
      {@required String mail, @required String pass}) async {
    bool isAuthenticated = false;
    http.Response response;
    var url =
        'https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/api/auth/login';
    Map data = {"password": pass, "email": mail};
    print("pass: $pass");
    print("mail: $mail");

    var body = json.encode(data);
    response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      isAuthenticated = true;
      token = json.decode(response.body)["data"]["token"];
      print("statusCode : ${response.statusCode}");
      print("response.body : ${response.body}");
      print("token: $token");
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }
}
