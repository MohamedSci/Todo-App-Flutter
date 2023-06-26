import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Constants/month_map.dart';
import 'package:todo_app/Filtering/filter_controller/filter_controller.dart';
import 'package:todo_app/Filtering/filter_dialoge/filter_dialoge.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/drawer/drawer_screen.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/states/states.dart';

import 'package:todo_app/TODO_List/navigation_screen/Navigation_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    DatabaseProvider get(context) =>
        BlocProvider.of<DatabaseProvider>(context, listen: false);
    super.initState();
  }
  @override
  void dispose() {
    ToDoController.get(context).setDrawerState(DrawerState.insert);

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Future<void> _refreshList() async {
      DatabaseProvider.get(context).fetchTasks();
    }

    return BlocConsumer<FilterController, ChangState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
        return BlocConsumer<DatabaseProvider, ChangState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            ToDoController toDoController = ToDoController.get(context);
            FilterController filterController = FilterController.get(context);

            return Scaffold(
              endDrawer: DrawerScreen(width: width, state: DrawerState.insert),
              key: scaffoldKey,
              floatingActionButton: InkWell(
                onTap: () {
                  if (scaffoldKey.currentState.isEndDrawerOpen) {
                    scaffoldKey.currentState.closeEndDrawer();
                    //close drawer, if drawer is open
                  } else {
                    scaffoldKey.currentState.openEndDrawer();
                    ToDoController.get(context).setDrawerState(DrawerState.insert);
                    //open drawer, if drawer is closed
                  }
                },
                child: Container(
                    height: width * 0.17,
                    width: width * 0.17,
                    decoration: const BoxDecoration(
                        color: Color(0xFF13A3FF),
                        borderRadius: BorderRadius.all(Radius.circular(28))),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: width * 0.09,
                    )),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      Color(0xAFF8B8F2),
                      Color(0xFFFFF2E4),
                    ],
                  ),
                ),
                width: width,
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                        width: width,
                        height: height * 0.15,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFFFFF2E4),
                                    onPressed: () async {
                                      ToDoController.get(context).setDrawerState(DrawerState.insert);
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const NavigationScreen()));
                                      },
                                    child: const Icon(
                                      Icons.home_filled,
                                      color: Colors.blue,
                                      size: 36,
                                    ))),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.2),
                                child: const Text(
                                  'Filtered ToDo',
                                  style: TextStyle(
                                    fontSize: 21,fontFamily: "Lato"
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFFFFF2E4),
                                    onPressed: () async {
                                      // ToDoController.get(context).setDrawerState(DrawerState.filter);
                                      await showDialog(
                                        context: context,
                                        builder: (context) => FilterDialoge(
                                              height: height,
                                              width: width,
                                            ));},
                                    child: const Icon(
                                      Icons.filter_list,
                                      color: Color(0xFFFE9299),
                                      size: 36,
                                    )))
                          ],
                        )),
                    SizedBox(
                      width: width,
                      height: height * 0.75,
                      child: RefreshIndicator(
                        onRefresh: _refreshList,
                        child: FutureBuilder<List<TaskModel>>(
                          future: DatabaseProvider.get(context).filterTasks(
                              color: filterController.getColorNum(), nameDesc: filterController.getNameText(),
                              date: filterController.getDateText(), time: filterController.getTimeText()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              return const SizedBox();
                            }
                            List<TaskModel> taskData =
                                snapshot.hasData ? snapshot.data : [];
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              itemCount: taskData?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                TaskModel currentTask = taskData[index];
                                return Dismissible(
                                  key: const Key("task"),
                                  onDismissed: (direction) {
                                    DatabaseProvider.get(context)
                                        .delete(currentTask.id);
                                    setState(() {
                                      taskData.removeAt(currentTask.id);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            '${currentTask.title} Deleted Successfully')));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        scaffoldKey.currentState.openEndDrawer();
                                        toDoController
                                            .setDrawerState(DrawerState.update);
                                        toDoController.setIdNum(currentTask.id);
                                        toDoController
                                            .setNameText(currentTask.title);
                                        toDoController
                                            .setColorNum(currentTask.color);
                                        toDoController
                                            .setDescString(currentTask.description);
                                        toDoController
                                            .setDateString(currentTask.date);
                                        toDoController
                                            .setTimeText(currentTask.time);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))),
                                        height: height * 0.1,
                                        width: width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Color(taskData[index].color),
                                                radius: 16,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                "  ${taskData[index].title}",
                                                overflow: TextOverflow.fade,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF181743),
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${currentTask.date.substring(8, 10)} ${monthMap[currentTask.date.substring(5, 7)]} ",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "${taskData[index].time}  ",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.indigo,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
