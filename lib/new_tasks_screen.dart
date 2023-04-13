import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/cubit/states.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:nour/sharing/sharing.component/constans.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks;
        return  ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index]),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
