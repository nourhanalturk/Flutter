import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/models/shop_app/change_favorites_model.dart';
import 'package:nour/models/shop_app/home_model.dart';
import 'package:nour/modules/shop_app/categories/categories_screen.dart';
import 'package:nour/modules/shop_app/favorites/favorites_screen.dart';
import 'package:nour/modules/shop_app/products/products_screen.dart';
import 'package:nour/modules/shop_app/settings/settings_screen.dart';
import 'package:nour/network/remote/dio_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
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
  Map <int ,bool >favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token:token ,
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
     // print(homeModel!.data?.banners[0].image);
    homeModel!.data!.products.forEach((element)
    {
     favorites.addAll({
       element.id!:element.in_favorites!
     });
    }
    );
    print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel  ;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


ChangeFavoritesModel? changeFavoritesModel ;
  void changeFavorites (int productId){
   favorites[productId] =!favorites[productId]!;
   emit(ShopChangeFavoritesState());

   DioHelper.postData(
      url: FAVORITES,
        data:
        {
      'product_id':productId
        },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!(changeFavoritesModel!.status !)){
        favorites[productId] =!favorites[productId]!;
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
      getHomeData();
      print("hiiiiiiiiiii"+favorites.toString());
      print(favorites[productId]);
    }).catchError((error){
     favorites[productId] =!favorites[productId]!;
      print(error.toString());
      emit(ShopErrorChangeFavoritesState());

    });
  }



  FavoritesModel? favoritesModel  ;
  void getFavoritesData(){
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      print(value?.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userData  ;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
     // token:token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value?.data);
      print(value?.data.toString());
      emit(ShopSuccessUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}