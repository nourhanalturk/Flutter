import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.dark,

      ),
      backgroundColor:HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      )

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ) ),
  fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(

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
  textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ) ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey
  ),
    fontFamily: 'Jannah',
);