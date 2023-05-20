import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/modules/shop_app/shop_login_screen/shop_cubit/shop_states.dart';
import 'package:nour/network/end_points.dart';
import 'package:nour/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

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
      emit(ShopSuccessLoginState());
    }).catchError((error){
      emit(ShopErrorLoginState(error.toString()));

    });
  }
}