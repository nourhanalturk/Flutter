import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nour/sharing/bloc_observer.dart';

import 'bmi_screen.dart';
import 'counter_screen.dart';
import 'layout_screen.dart';
import 'login_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeLayout(),
    );
  }
}





