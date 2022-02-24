import 'package:shop_app/presentation_layer/models/register_model/register_model.dart';

abstract class ShopRegisterStates {}

class InitialState extends ShopRegisterStates {}

class RegisterLoadingState extends ShopRegisterStates {}

class RegisterSuccessState extends ShopRegisterStates {
  final ShopRegisterModel? registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends ShopRegisterStates {}

class ChangeRegisterEyeSecureState extends ShopRegisterStates {}
