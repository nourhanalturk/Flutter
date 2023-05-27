import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/models/shop_app/home_model.dart';
import 'package:nour/modules/shop_app/categories/categories_screen.dart';
import 'package:nour/modules/shop_app/favorites/favorites_screen.dart';
import 'package:nour/modules/shop_app/products/products_screen.dart';
import 'package:nour/modules/shop_app/settings/settings_screen.dart';
import 'package:nour/network/remote/dio_helper.dart';

import '../../../network/end_points.dart';
import '../../../sharing/sharing.component/constans.dart';

class ShopCubit extends Cubit<ShopStates> {
  //ShopCubit(super.initialState);
  ShopCubit():super (ShopInitState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List <Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index ;
    emit(ShopChangeNavBarState());
  }

  HomeModel? homeModel  ;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token:token ,
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      print(homeModel!.data?.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}