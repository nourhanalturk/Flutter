import 'package:nour/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopInitLoginState extends ShopLoginStates{}

class ShopLoadingLoginState extends ShopLoginStates{}
class ShopSuccessLoginState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopSuccessLoginState(this.loginModel);

}
class ShopErrorLoginState extends ShopLoginStates  {
  final String error;
  ShopErrorLoginState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}