import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nour/layout/news_layout.dart';
import 'package:nour/network/remote/dio_helper.dart';
import 'package:nour/sharing/bloc_observer.dart';

import 'modules/bmi_screen/bmi_screen.dart';
import 'modules/counter_screen/counter_screen.dart';
import 'modules/layout1_screen/layout_screen.dart';
import 'modules/login_screen/login_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,

          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          iconTheme: IconThemeData(
            color: Colors.black87,
          )

        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home:NewsLayout(),
    );
  }
}





