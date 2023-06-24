import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/TODO_List/Screens/add_task/Add_Task.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OnUpdate(int id) {
    int enteryid = id;
    if (titleController.text != "") {
      print("id = $id");
      TaskModel updateTask = TaskModel(
          color: 0,
          title: titleController.text,
          description: descriptionController.text,
          date: "",
      time: "");
      print("One Task module is updated");
      DatabaseProvider.get(context).update(updateTask, enteryid);
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
        return Scaffold(
          key: _scaffoldKey,
          floatingActionButton: SizedBox(
            height: 100,
            width: 100,
            child: FloatingActionButton(
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTask(),)),

                  // Scaffold.of(context).openDrawer(),

              // await showDialog(
              //     context: context,
              //     builder: (BuildContext cxt) {
              //       return const AddTask();
              //     });
              // },
              child: const Icon(Icons.add),
            ),
          ),

          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xFF0DC4F4),
                  Color(0xFFFFA5D7)
                ],
              ),
            ),
            width: width,
            height: height,
            child: Column(
              children: [
                SizedBox(
                    width: width ,height: height * 0.15,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Align(alignment: Alignment.center,
                    child: Text(
                      'TODO',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),],)),
                SizedBox(
                 width: width, height: height * 0.85,
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          itemCount: taskData?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final item = taskData[index];
                            return Dismissible(
                              key: const Key("task"),
                              onDismissed: (direction) {
                                DatabaseProvider.get(context).delete(item.id);
                                setState(() {
                                  taskData.removeAt(item.id);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${item.title} Deleted Successfully')));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                height: height * 0.15,
                                width: width,
                                child:
                                  Row(
                                    children: [
                                      Expanded(
                                       flex:1,
                                        child: CircleAvatar(
                                          backgroundColor: Color(taskData[index].color),
                                          radius: 20,),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          taskData[index].title,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.amber,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              taskData[index].date,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              taskData[index].time,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
