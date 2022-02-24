import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation_layer/models/login_model/login_model.dart';
import 'package:shop_app/presentation_layer/modules/home/home.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_bloc/states.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/web_services/dio_heloper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(intitial_State());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

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
    emit(change_eye_secure_State());
  }

  //////////webServices//////////////
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(loading_State());
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(success_State(loginModel!));
    }).catchError((error) {
      print('error when postData in login Screen:${error.toString()}');
      emit(error_State(error));
    });
  }
}
