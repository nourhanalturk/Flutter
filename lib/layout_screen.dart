import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nour/archive_tasks_screen.dart';
import 'package:nour/done_tasks_screen.dart';
import 'package:nour/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

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
  void initState() {
  creatDataBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          titles[currentindex],
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
         insertDatabase();

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


  Database? database;

  void creatDataBase () async
  {
   database =  await openDatabase(
    'ToDo.db',
    version: 2,
    onCreate:(db , version)
    {
print("database created");

    db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT ,date TEXT ,status TEXT)').then((value)
    {
    print('table created');

    }).catchError((error){

      print('Error is ${error}');

    });
    },
    onOpen: (db) {
      print("database opened");
    },
  );
  }

  void insertDatabase (){
  database!.transaction((txn) {
    txn.rawInsert('INSERT INTO tasks(title,date,status) VALUES ("hi","30/4","on")').then((value)
    {

        print('inserted successfully');


    }).catchError((error){
             print(error);
    });
            return Future.value();
  });


  }
}
