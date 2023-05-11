import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/cubit/states.dart';


import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/settings/settings.dart';
import '../../modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit():super(NewsInitialState());
  static NewsCubit get(context)=> BlocProvider.of(context);
  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
    icon: Icon(
    Icons.business,
    ),
    label: 'Business',
  ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',
    ),
  ];
  List <Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),

  ];

  void changeBottomNavBar (int index){
    currentIndex = index ;
     emit(NewsBottomNavState());
  }

}