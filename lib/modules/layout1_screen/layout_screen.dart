import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nour/modules/archived_screen/archive_tasks_screen.dart';
import 'package:nour/modules/done_screen/done_tasks_screen.dart';
import 'package:nour/modules/tasks_screen/new_tasks_screen.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/cubit/states.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:nour/sharing/sharing.component/constans.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget
{

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();


  String? text ;


  var titlecontroller = TextEditingController();
  var timecontroller =TextEditingController();
  var datecontroller = TextEditingController();







  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);

         return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title:Text(
                cubit.titles[cubit.currentindex],
              ) ,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isbottomsheet)
                {
                  if(formkey.currentState!.validate()){
                    cubit.insertDatabase(title: titlecontroller.text, date: datecontroller.text, time: timecontroller.text);
                    // insertDatabase(
                    //   title: titlecontroller.text,
                    //   date: datecontroller.text,
                    //   time: timecontroller.text,
                    // ).then( (value) {
                    //
                    // });


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
                            const SizedBox(
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
                            const SizedBox(
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
                                    lastDate: DateTime.parse('2023-04-20'),
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
                  cubit.changeBottomsheetState(
                      isShow: false,
                      icon: Icons.edit,
                  );
                  });

                 cubit.changeBottomsheetState(
                     isShow: true,
                     icon: Icons.add,
                 );
                }


              },
              child: Icon(
                cubit.icon1,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentindex,
              onTap: (index) {
               cubit.changeIndex(index);
                // setState(() {
                //   currentindex=index;
                // });
              },
              items: const [
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
            body: cubit.screen[cubit.currentindex],
            // ConditionalBuilder(
            //   condition: true,
            //   builder:(context) => cubit.screen[cubit.currentindex],
            //   fallback:(context) => const Center(
            //       child: CircularProgressIndicator()
            //   ),
            // ),

          );
        },
      ),
    );
  }






}





