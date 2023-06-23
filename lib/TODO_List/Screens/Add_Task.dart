import 'package:flutter/material.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/TODO_List/widgets/color_listview.dart';
import 'package:todo_app/TODO_List/widgets/text_widget.dart';



class AddTask extends StatefulWidget {
  const AddTask({Key key, }) : super(key: key);
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

TextEditingController nameController = TextEditingController();
TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child:  Container(
        height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: kBackColor,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: ListView(
              children: [
               TextWidget(color: const Color.fromRGBO(24, 23, 67, 0.2),fontSize: 12,txt: "Color"),
                ColorListView(),
                TextWidget(color: const Color.fromRGBO(24, 23, 67, 0.2),fontSize: 12,txt: "Name"),
                 Stack(
                   children: [
                     TextField(
                      controller: nameController,
                       style: const TextStyle(fontSize: 12,fontFamily: "Lato",color: Color(0xFF17163F)),
                       decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                      ),
                ),
                     Positioned(
                       bottom: -1,
                       child: Container(
                         height: 10,
                         width: MediaQuery.of(context).size.width - 20,
                         decoration:  const BoxDecoration(
                           borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(10),
                             bottomRight: Radius.circular(10),
                           ),
                           gradient: LinearGradient(
                             colors: [
                               Color(0xFFFE1E9A),
                               Color(0xFF254DDE),
                             ],
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
                TextWidget(color: const Color.fromRGBO(24, 23, 67, 0.2),fontSize: 12,txt: "Description"),
                TextField(
                  controller: descController,
                  maxLength: 4,
                  style: const TextStyle(fontSize: 12,fontFamily: "Lato",color: Color(0xFF17163F)),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
                TextWidget(color: const Color.fromRGBO(24, 23, 67, 0.2),fontSize: 12,txt: "Date"),
                const SizedBox(),
                TextWidget(color: const Color.fromRGBO(24, 23, 67, 0.2),fontSize: 12,txt: "Time"),
                const SizedBox(),
              ],
            ),
          ),
        );

  }
}
