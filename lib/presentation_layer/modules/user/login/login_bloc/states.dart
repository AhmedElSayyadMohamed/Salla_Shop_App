import 'package:shop_app/presentation_layer/models/login_model/login_model.dart';

abstract class ShopLoginStates {}

class intitial_State extends ShopLoginStates {}

class loading_State extends ShopLoginStates {}

class success_State extends ShopLoginStates {
  final ShopLoginModel loginModel;
  success_State(this.loginModel);
}

class error_State extends ShopLoginStates {
  String error;
  error_State(this.error);
}

class change_eye_secure_State extends ShopLoginStates {}
