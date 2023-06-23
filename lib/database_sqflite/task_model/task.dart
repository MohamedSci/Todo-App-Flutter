import 'package:todo_app/database_sqflite/database_provider.dart';


class Task {
  int id;
  String title;
  String description;
  String date;

  Task(id ,this.title, {this.description, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_DESCRIPTION: description,
      DatabaseProvider.COLUMN_DATE: date,
    };
       return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    title = map[DatabaseProvider.COLUMN_TITLE];
    description = map[DatabaseProvider.COLUMN_DESCRIPTION];
    date = map[DatabaseProvider.COLUMN_DATE];
  }
}
