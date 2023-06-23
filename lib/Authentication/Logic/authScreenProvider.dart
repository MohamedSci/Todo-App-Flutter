import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreenProvider extends Cubit<ChangState> {
  AuthScreenProvider() : super(InitialState());

  static AuthScreenProvider get(context) => BlocProvider.of(context);

  String mailTxt = "";
  setMailText(String mail){
    mailTxt = mail;
    emit(SetMailTextState());
  }
  String getMailText(){
    return mailTxt;
  }

  String passTxt = "";
  setPassString(String pass){
    passTxt = pass;
    emit(SetPassTextState());
  }
  String getPassText(){
    return passTxt;
  }

}