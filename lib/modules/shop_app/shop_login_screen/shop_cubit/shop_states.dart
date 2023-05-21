abstract class ShopLoginStates {}

class ShopInitLoginState extends ShopLoginStates{}

class ShopLoadingLoginState extends ShopLoginStates{}
class ShopSuccessLoginState extends ShopLoginStates{}
class ShopErrorLoginState extends ShopLoginStates  {
  final String error;
  ShopErrorLoginState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}