import 'package:nour/models/shop_app/login_model.dart';

abstract class SocialLoginStates {}

class SocialInitLoginState extends SocialLoginStates{}

class SocialLoadingLoginState extends SocialLoginStates{}
class SocialSuccessLoginState extends SocialLoginStates{

}
class SocialErrorLoginState extends SocialLoginStates  {
  final String error;
  SocialErrorLoginState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates{}