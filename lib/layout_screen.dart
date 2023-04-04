import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/archive_tasks_screen.dart';
import 'package:nour/done_tasks_screen.dart';
import 'package:nour/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {


  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentindex =0 ;
  String? text ;


  List<Widget> screen =[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];

  List<String> titles =[
    "task",
    "done",
    "archived",

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          titles[currentindex],
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async
        {
          var name =await myName() ;
          print(name);

        },
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex=index;
          });
        },
        items: [
        BottomNavigationBarItem(
            icon:Icon(
          Icons.menu,
        ),
          label: "Tasks",

        ),
          BottomNavigationBarItem(
              icon:Icon(
            Icons.check_circle_outline,
          ) ,
            label: "Done",

          ),
          BottomNavigationBarItem(
              icon:Icon (
            Icons.archive_outlined,
          ) ,
            label: "Archive",
          ),

        ],

      ),
      body: screen[currentindex],

    );
  }

  Future<String> myName ()  async
  {
    return'nourhan';
  }
}
