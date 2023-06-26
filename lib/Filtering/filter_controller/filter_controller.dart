//
// import 'package:todo_app/states/states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class FilterController extends Cubit<ChangState> {
//   FilterController() : super(InitialState());
//
//   static FilterController get(context) => BlocProvider.of(context);
//
//
//   int colorNum = 0;
//   setColorNum(int color){
//     colorNum = color;
//     emit(SetColorNumState());
//   }
//   int getColorNum(){
//     return colorNum;
//   }
//
//
//   String name = "";
//   setNameText(String nm){
//     name = nm;
//     emit(SetNameTextState());
//   }
//   String getNameText(){
//     return name;
//   }
//
//   String descTxt = "";
//   setDescString(String desc){
//     descTxt = desc;
//     emit(SetDescTextState());
//   }
//   String getDescText(){
//     return descTxt;
//   }
//
//
//   String dateTxt = "";
//   setDateString(String date){
//     dateTxt = date;
//     emit(SetDateTextState());
//   }
//   String getDateText(){
//     return dateTxt;
//   }
//
//   String timeTxt = "";
//   setTimeText(String time){
//     timeTxt = time;
//     emit(SetTimeTextState());
//   }
//   String getTimeText(){
//     return timeTxt;
//   }
//
// }