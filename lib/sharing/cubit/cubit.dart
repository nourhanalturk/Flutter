import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/sharing/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../archive_tasks_screen.dart';
import '../../done_tasks_screen.dart';
import '../../new_tasks_screen.dart';
import '../sharing.component/constans.dart';

class AppCubit extends Cubit<AppStates> {
  Database? database;

  AppCubit ():super(AppInitState());

  static AppCubit get(context)=> BlocProvider.of(context);
  int currentindex =0 ;
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
  List<Map> tasks =[];

  void changeIndex (int index){

    currentindex =index;
    emit(AppChangeButtomNavBarState());
  }

  void createDataBase ()
  {
     openDatabase(
      'ToDo4.db',
      version: 2,
      onCreate:(database , version)
      {
        print("database created");

        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT ,date TEXT ,time TEXT,status TEXT)').then((value)
        {
          print('table created');

        }).catchError((error){

          print('Error is ${error}');

        });
      },
      onOpen: (database) {

        getDataFromDatabase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
     });
  }

  Future insertDatabase ({
    required String title,
    required String date,
    required String time,
  }) async
  {
    return await database!.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")'
      ).then((value)
      {

        print('inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database).then((value) {
          tasks=value;
          print(tasks);
          emit(AppGetDatabaseState());
        });


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


  bool isbottomsheet =false;
  IconData icon1 = Icons.edit;

  void changeBottomsheetState({
      required bool isShow ,
      required IconData icon ,
  }
      ){
   icon1 = icon;
   isbottomsheet = isShow;

   emit(AppChangeBottomSheetState());
  }
}