import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/cubit/states.dart';


import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/settings/settings.dart';
import '../../modules/sports/sports_screen.dart';
import '../../network/remote/dio_helper.dart';

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

  List<dynamic>business =[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url:'v2/everything' ,

        query:{
          'q':'tesla',
          'sortBy':'publishedAt',
          'apiKey':'19f2f6d6044a4c4899db331be9a42894',
        }

    ).then((value)
    {

      business = value?.data['articles'];
      print(value?.data['articles'][0]);
     emit(NewsGetBusinessDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessDataErrorState(error.toString()));
    });
  }

}