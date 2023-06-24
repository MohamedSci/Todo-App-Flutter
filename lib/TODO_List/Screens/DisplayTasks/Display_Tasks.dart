import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Constants/month_map.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/TODO_List/drawer/drawer_screen.dart';
import 'package:todo_app/TODO_List/drawer/drawer_state_enum.dart';
import 'package:todo_app/TODO_List/task_model/task_model.dart';
import 'package:todo_app/states/states.dart';

class DisplayingTasks extends StatefulWidget {
  @override
  _DisplayingTasksState createState() => _DisplayingTasksState();
}

class _DisplayingTasksState extends State<DisplayingTasks> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  OnUpdate(int id) {
    if (titleController.text != "") {
      print("id = $id");
      TaskModel updateTask = TaskModel(
          color: 0,
          title: titleController.text,
          description: descriptionController.text,
          date: "",
          time: "");
      print("One Task module is updated");
      DatabaseProvider.get(context).update(updateTask);
      print("One Task Updated; all finished");
    } else {
      print("there is no title");
    }
  }

  @override
  void initState() {
    DatabaseProvider get(context) =>
        BlocProvider.of<DatabaseProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Future<void> _refreshList() async {
      DatabaseProvider.get(context).getTasks();
    }

    return BlocConsumer<DatabaseProvider, ChangState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        ToDoController toDoController = ToDoController.get(context);
        return Scaffold(
          drawer: DrawerScreen(width: width, state: DrawerState.insert),
          key: scaffoldKey,
          floatingActionButton: InkWell(
            onTap: () {
              if (scaffoldKey.currentState.isDrawerOpen) {
                scaffoldKey.currentState.closeDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState.openDrawer();
                ToDoController.get(context)
                    .setDrawerState(DrawerState.insert);
                //open drawer, if drawer is closed
              }
            },
            child: Container(
              height: width * 0.17,
              width: width * 0.17,
                decoration: const BoxDecoration(
                    color: Color(0xFF13A3FF),
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
              child:  Icon(Icons.add,color: Colors.white,size: width * 0.09,)
            ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'TODO',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: width,
                  height: height * 0.75,
                  child: RefreshIndicator(
                    onRefresh: _refreshList,
                    child: FutureBuilder<List<TaskModel>>(
                      future: DatabaseProvider.get(context).getTasks(),
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
                                    scaffoldKey.currentState.openDrawer();
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
                                        borderRadius: BorderRadius.all(Radius.circular(14))
                                    ),
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
                                                "${currentTask.date.substring(8, 10)} ${monthMap[currentTask.date.substring(5, 7)]}  ",
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
}
