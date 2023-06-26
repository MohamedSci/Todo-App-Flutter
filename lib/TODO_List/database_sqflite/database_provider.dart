import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/states/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseProvider extends Cubit<ChangState> {
  DatabaseProvider() : super(InitialState());

  //take object-
  static DatabaseProvider get(context) => BlocProvider.of(context);
  static const String TABLE_task = "task";
  static const String COLUMN_ID = "id";
  static const String COLUMN_COLOR = "color";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_DATE = "date";
  static const String COLUMN_TIME = "time";

  Database _database;

  Future<Database> get database async {
    print("database getter called");
//affected by task class task_model.dart directory:model
    if (_database != null) {
      print('opening previous sqflite database');
      return _database;
    }
    _database = await createDatabase();
    print("created  database sqflite");
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'taskDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating task table");
        await database.execute("CREATE TABLE $TABLE_task ("
            "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
            "$COLUMN_COLOR INTEGER,"
            "$COLUMN_TITLE TEXT,"
            "$COLUMN_DESCRIPTION TEXT,"
            "$COLUMN_DATE TEXT,"
            "$COLUMN_TIME TEXT"
            ");");
        emit(DatabaseInitialState());
      },
    );
  }

  Future<List<TaskModel>> fetchTasks() async {
    final db = await database;
    List<TaskModel> taskList = [];
    try {
      var tasks = await db.query(TABLE_task, columns: [
        COLUMN_ID,
        COLUMN_COLOR,
        COLUMN_TITLE,
        COLUMN_DESCRIPTION,
        COLUMN_DATE,
        COLUMN_TIME,
      ],);
      // if (tasks.isEmpty) return [];
      print(tasks);
      taskList = List<TaskModel>();
      tasks.forEach((currenttask) {
        TaskModel task = TaskModel.fromMap(currenttask);
        taskList.add(task);
      });
      print(taskList);
      Fluttertoast.showToast(
          msg: "Data Retrieved Successfully !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Data Retrieved Exception $e");
    }
    // setTasksList(tskList: taskList);
    taskList.sort((a, b) => a.date.compareTo(b.date));
    taskList.sort((a, b) => a.time.compareTo(b.time));
    return taskList;
  }

  bool isJoined = false;

  setFilterIsJoined(bool joined) {
    isJoined = joined;
    emit(SetIsFilterJoinedState());
  }

  bool getFilterIsJoined() {
    return isJoined;
  }

  Future<List<TaskModel>> filterTasks(
      {@required int color,
      @required String nameDesc,
      @required String date,
      @required String time}) async {
    String opt = getFilterIsJoined() ? "AND" : "OR";
    List<TaskModel> taskList = [];
    final db = await database;
    try {
      print("filter color $color namedesc $nameDesc date $date  time $time ");
      List<Map> tasks = await db.rawQuery(
          'SELECT * FROM $TABLE_task WHERE $COLUMN_COLOR = ? or'
          ' $COLUMN_TITLE like ? or '
          '$COLUMN_DESCRIPTION like ? or '
          '$COLUMN_DATE = ? or'
          ' $COLUMN_TIME = ?',
          [color, "%$nameDesc%", "%$nameDesc%", date, time]);
      // List<Map> tasks = await db.query(TABLE_task,
      //     columns: [
      //       COLUMN_ID,
      //       COLUMN_COLOR,
      //       COLUMN_TITLE,
      //       COLUMN_DESCRIPTION,
      //       COLUMN_DATE,
      //       COLUMN_TIME,
      //     ],
      //     where: "$COLUMN_TITLE = ?  ",
      //     whereArgs:["%$nameDesc%"],
      //     orderBy: 'id'
      // );

      // List<Map> tasks = await db.query(TABLE_task,
      //     columns: [
      //       COLUMN_ID,
      //       COLUMN_COLOR,
      //       COLUMN_TITLE,
      //       COLUMN_DESCRIPTION,
      //       COLUMN_DATE,
      //       COLUMN_TIME,
      //     ],
      //     where: "$COLUMN_COLOR = ? $opt $COLUMN_TITLE LIKE ? $opt $COLUMN_DESCRIPTION LIKE ?  $opt $COLUMN_DATE = ?  $opt $COLUMN_TIME  = ? ",
      //     whereArgs:[color, "%$nameDesc%", "%$nameDesc%", date, time],
      //     orderBy: 'id'
      //     );

      taskList = List<TaskModel>();
      tasks.forEach((currenttask) {
        TaskModel task = TaskModel.fromMap(currenttask);
        taskList.add(task);
      });
      print("Data Filtered Successfully ! ");
      print("taskList Filtered $tasks");
      Fluttertoast.showToast(
          msg: "Data Filtered Successfully !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Data Filtration Exception $e");
    }
    taskList.sort((a, b) => a.date.compareTo(b.date));
    taskList.sort((a, b) => a.time.compareTo(b.time));
    return taskList;
  }

  insert(TaskModel task) async {
    final db = await database;
    var i;
    try {
      i = await db.insert(TABLE_task, task.toMap());
      Fluttertoast.showToast(
          msg: "Inserted Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Insertion Exception $e");
    }
    emit(DatabaseAddState());
    return i;
  }

  Future<int> delete(int id) async {
    final db = await database;
    int d;
    try {
      d = await db.delete(
        TABLE_task,
        where: "id = ?",
        whereArgs: [id],
      );
      print("One Item deleted");
      emit(DatabaseDeleteState());
      Fluttertoast.showToast(
          msg: "Removed Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Removal Exception $e");
    }
    return d;
  }

  Future<int> update(
    TaskModel task,
  ) async {
    final db = await database;
    int u;
    try {
      u = await db.update(
        TABLE_task,
        task.toMap(),
        where: "id = ?",
        whereArgs: [task.id],
      );
      Fluttertoast.showToast(
          msg: "Updated !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amberAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Update Exception $e");
    }
    emit(DatabaseUpdateState());
    return u;
  }
}
