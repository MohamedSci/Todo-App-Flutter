import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoController extends Cubit<ChangState> {
  ToDoController() : super(InitialState());

  static ToDoController get(context) => BlocProvider.of(context);



  DrawerState drawerState = DrawerState.insert;
  setDrawerState(DrawerState state){
    drawerState = state;
    emit(SetDrawerStateState());
  }
  DrawerState getDrawerState(){
    return drawerState;
  }

  TaskModel taskModel ;
  setTaskModel(TaskModel tsk){
    taskModel = tsk;
    emit(SetTaskModelState());
  }
  TaskModel getTaskModel(){
    return taskModel;
  }

  int idNum = 0;
  setIdNum(int nm){
    idNum = nm;
    emit(SetIdNumState());
  }
  int getIdNum(){
    return idNum;
  }

  int colorNum = 0;
  setColorNum(int color){
    colorNum = color;
    emit(SetColorNumState());
  }
  int getColorNum(){
    return colorNum;
  }


  String name = "";
  setNameText(String nm){
    name = nm;
    emit(SetNameTextState());
  }
  String getNameText(){
    return name;
  }

  String descTxt = "";
  setDescString(String desc){
    descTxt = desc;
    emit(SetDescTextState());
  }
  String getDescText(){
    return descTxt;
  }


  String dateTxt = "";
  setDateString(String date){
    dateTxt = date;
    emit(SetDateTextState());
  }
  String getDateText(){
    return dateTxt;
  }

  String timeTxt = "";
  setTimeText(String time){
    timeTxt = time;
    emit(SetTimeTextState());
  }
  String getTimeText(){
    return timeTxt;
  }

}