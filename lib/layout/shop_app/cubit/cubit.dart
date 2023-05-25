import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/modules/shop_app/categories/categories_screen.dart';
import 'package:nour/modules/shop_app/favorites/favorites_screen.dart';
import 'package:nour/modules/shop_app/products/products_screen.dart';
import 'package:nour/modules/shop_app/settings/settings_screen.dart';

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

}