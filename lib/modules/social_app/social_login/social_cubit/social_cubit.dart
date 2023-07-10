import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/shop_app/login_model.dart';
import 'package:nour/modules/social_app/social_login/social_cubit/social_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {

  ShopLoginModel? loginModel ;

  SocialLoginCubit():super (SocialInitLoginState()) ;
  static SocialLoginCubit get(context)=> BlocProvider.of(context);

  void userLogin ({
    required String email ,
    required String password ,

}){
  emit(SocialLoadingLoginState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
  ).then((value) {
    print(value.user!.email);
    print(value.user!.uid);
     emit(SocialSuccessLoginState(value.user!.uid));
  }).catchError((error){
    emit(SocialErrorLoginState(error.toString()));

  });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPass = true ;

  void changePasswordVisibility(){
    isPass =!isPass ;
    suffix= isPass ?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());

  }
}