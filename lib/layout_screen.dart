import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nour/archive_tasks_screen.dart';
import 'package:nour/done_tasks_screen.dart';
import 'package:nour/new_tasks_screen.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:nour/sharing/sharing.component/constans.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {


  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  int currentindex =0 ;
  String? text ;
  bool isbottomsheet =false;
  IconData icon1 = Icons.edit;

  var titlecontroller = TextEditingController();
  var timecontroller =TextEditingController();
  var datecontroller = TextEditingController();

  Database? database;


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
      key: scaffoldkey,
      appBar: AppBar(
        title:Text(
          titles[currentindex],
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isbottomsheet)
          {
            if(formkey.currentState!.validate()){
              insertDatabase(
                  title: titlecontroller.text,
                  date: datecontroller.text,
                  time: timecontroller.text,
              ).then( (value) {

              });


            }
          }else{
            scaffoldkey.currentState?.showBottomSheet(
                    (context) =>Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: titlecontroller,
                                type: TextInputType.text,
                                validate: (value){
                                  if(value!.isEmpty){
                                   return 'title must not be empty';
                                  }
                                  return null ;
                                },
                                text: "Task title",
                                prefex: Icons.title,

                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaultFormField(
                                controller: timecontroller,
                                type: TextInputType.datetime,
                                validate: (value){
                                  if(value!.isEmpty){
                                    return 'time must not be empty';
                                  }
                                },
                                text: "Task time",
                                prefex: Icons.watch_later,
                                ontap: (){
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                  ).then((value){
                                    timecontroller.text = value!.format(context).toString();

                                  });
                                }
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaultFormField(
                                controller: datecontroller,
                                type: TextInputType.datetime,
                                validate: (value){
                                  if(value!.isEmpty){
                                    return 'Date must not be empty';
                                  }
                                },
                                text: "Task date",
                                prefex: Icons.calendar_today,
                                ontap: (){
                                  showDatePicker(
                                      context: context, 
                                      initialDate: DateTime.now(), 
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-04-10'),
                                  ).then( (value) {
                                    print(DateFormat.yMMMd().format(value!));
                                    datecontroller.text=DateFormat.yMMMd().format(value!);
                                  });
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
            ).closed.then((value) {
              isbottomsheet =false;
              setState(() {
                icon1= Icons.edit;
              });
            });

            isbottomsheet = true;
           setState(() {
             icon1=Icons.add;
           });
          }


        },
        child: Icon(
          icon1,
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
      body:screen[currentindex]
      // ConditionalBuilder(
      //   condition: tasks.length>0,
      //     builder:(context) => screen[currentindex],
      //     fallback:(context) => Center(child: CircularProgressIndicator()),
      //     ),

    );
  }




  void creatDataBase () async
  {
   database =  await openDatabase(
    'ToDo3.db',
    version: 2,
    onCreate:(db , version)
    {
print("database created");

    db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT ,date TEXT ,time TEXT,status TEXT)').then((value)
    {
    print('table created');

    }).catchError((error){

      print('Error is ${error}');

    });
    },
    onOpen: (db) {
      print("database opened");
      getDataFromDatabase(db).then((value) {
        tasks=value;
        print(tasks);
      });
    },
  );
  }

  Future insertDatabase ({
    required String title,
    required String date,
    required String time,
}) async
  {
  return await database!.transaction((txn) {
    txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")').then((value)
    {

        print('inserted successfully');


    }).catchError((error){
             print(error);
    });
            return Future.value();
  });


  }

  Future<List<Map>> getDataFromDatabase(database) async
  {
  return await database.rawQuery('SELECT * FROM tasks');

  }

}
