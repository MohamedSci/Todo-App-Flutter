import 'dart:math';

import 'package:flutter/cupertino.dart';

int generateRandomNumber(){
  Random random = Random();
  int randomNumber = random.nextInt(10000000);
  return randomNumber;
}

int minutesBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day,from.hour ,from.minute);
  to = DateTime(to.year, to.month, to.day ,to.hour , to.minute );
  return (to.difference(from).inMinutes).round();
}

int convertDateStringToInt({@required String date,@required int start ,@required int end}){
 return int.parse(date.substring(start,end).toString());
}