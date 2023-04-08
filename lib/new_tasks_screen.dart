import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:nour/sharing/sharing.component/constans.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index]),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey,
        ),
        itemCount: tasks.length,
    );
  }
}
