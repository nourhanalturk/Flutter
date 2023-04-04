import 'package:flutter/material.dart';

import 'bmi_screen.dart';
import 'layout_screen.dart';
import 'login_screen.dart';

void main() {
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





