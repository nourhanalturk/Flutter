import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/states.dart';
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
}