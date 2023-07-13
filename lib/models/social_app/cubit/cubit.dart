import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/modules/social_app/chats/chats_screen.dart';
import 'package:nour/modules/social_app/feeds/feeds_screen.dart';
import 'package:nour/modules/social_app/new_post/new_%5Bpost_screen.dart';
import 'package:nour/modules/social_app/settings/settings_screen.dart';
import 'package:nour/modules/social_app/users/users_screen.dart';
import 'package:nour/sharing/sharing.component/constans.dart';

import '../social_user_model.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitState());
  static SocialCubit get(context) =>BlocProvider.of(context);
  SocialUsersModel? socialUsersModel;
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          socialUsersModel = SocialUsersModel.fromJson(value.data()!);
          print(value.data());
      emit(SocialGetUserSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));

    });
  }

  int currentIndex =0;
  List<Widget>screens =[
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String>titles =[
  'Home',
    'Chats',
    'Post',
    'Users',
    'Settings'
  ];
  void changeBottomNavBar(int index){

    if(index==2)
      emit(SocialNewPostState());
    else {
      currentIndex =index;
      emit(SocialChangeBottomNavBarState());
    }


  }
}