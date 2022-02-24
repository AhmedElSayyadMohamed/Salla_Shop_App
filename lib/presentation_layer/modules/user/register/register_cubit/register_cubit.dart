import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation_layer/models/register_model/register_model.dart';
import 'package:shop_app/presentation_layer/modules/user/register/register_cubit/register_state.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/web_services/dio_heloper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(InitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ////////////variable//////////////

  bool obSecure = true;
  Widget suffix = const Icon(
    Icons.visibility_off_outlined,
  );

  ////////////Methods///////////////

  void visibleEyeOrNot() {
    obSecure = !obSecure;
    suffix = obSecure
        ? const Icon(
            Icons.visibility_off_outlined,
          )
        : const Icon(
            Icons.remove_red_eye_outlined,
          );
    emit(ChangeRegisterEyeSecureState());
  }

  //////////webServices//////////////
  ShopRegisterModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String userPhone,
    required String username,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: register,
      data: {
        'name': username,
        'email': email,
        'password': password,
        'phone': userPhone,
      },
    ).then((value) {
      // print(value.data);
      registerModel = ShopRegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print('error when postData in register Screen:${error.toString()}');
      emit(RegisterErrorState());
    });
  }
}
