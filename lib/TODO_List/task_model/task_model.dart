import 'package:flutter/foundation.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';


class TaskModel {
  int id;
  int color;
  String title;
  String description;
  String date;
  String time;

  TaskModel({@required this.id,@required this.color, @required this.title,
    @required  this.description,@required  this.date, @required  this.time});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.COLUMN_COLOR: color,
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_DESCRIPTION: description,
      DatabaseProvider.COLUMN_DATE: date,
      DatabaseProvider.COLUMN_TIME: time,

    };
       return map;
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    color = map[DatabaseProvider.COLUMN_COLOR];
    title = map[DatabaseProvider.COLUMN_TITLE];
    description = map[DatabaseProvider.COLUMN_DESCRIPTION];
    date = map[DatabaseProvider.COLUMN_DATE];
    time = map[DatabaseProvider.COLUMN_TIME];
  }
}
