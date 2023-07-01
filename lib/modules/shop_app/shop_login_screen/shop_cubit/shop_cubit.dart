import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/shop_app/login_model.dart';
import 'package:nour/modules/shop_app/shop_login_screen/shop_cubit/shop_states.dart';
import 'package:nour/network/end_points.dart';
import 'package:nour/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginModel? loginModel ;

  ShopLoginCubit():super (ShopInitLoginState()) ;
  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  void userLogin ({
    required String email ,
    required String password ,

}){
  emit(ShopLoadingLoginState());
    DioHelper.postData(
        url: LOGIN,
        data: {
      'email':email,
      'password':password,
        }
    ).then((value) {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);
      print(loginModel!.message);
      print(loginModel!.data!.token);

      emit(ShopSuccessLoginState(loginModel!));
    }).catchError((error){
      emit(ShopErrorLoginState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPass = true ;

  void changePasswordVisibility(){
    isPass =!isPass ;
    suffix= isPass ?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());

  }
}