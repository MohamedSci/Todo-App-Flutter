import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/TODO_List/Screens/add_task/screen/Add_Task.dart';
import 'package:todo_app/database_sqflite/database_provider.dart';
import 'package:todo_app/database_sqflite/task_model/task.dart';
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
      TaskModel updateTask = TaskModel(enteryid, titleController.text,
          description: descriptionController.text, date: "");
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
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'TODO',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  return ListView.separated(
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
                              SnackBar(content: Text('$item dismissed')));
                        },
                        background: Container(color: Colors.red),
                        child: ClipRect(
                          clipBehavior: Clip.hardEdge,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            selectedTileColor: Colors.amberAccent,
                            tileColor: Colors.pink,
                            title: Text(
                              taskData[index].title,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  taskData[index].description,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  taskData[index].date,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            onLongPress: () {
                              titleController.text = item.title;
                              descriptionController.text = item.description;
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    SingleChildScrollView(
                                  child: AlertDialog(
                                    title: const Text("What's new"),
                                    content: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Title :",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.amber,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: "Title"),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                controller: titleController,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Title is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Description :",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.amber,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 8,
                                                maxLength: 1000,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            "description"),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                controller:
                                                    descriptionController,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 2),

                                        //there is two raised button need {Style}
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Update'),
                                              onPressed: () {
                                                OnUpdate(item.id);
                                                Navigator.pop(context, 'OK');
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.deepOrange,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
