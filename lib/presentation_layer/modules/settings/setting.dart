import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_screen.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class Setting extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is ShopGetUserDataSuccess) {
          showToast(
              message: '${state.userDataModel!.message}',
              state: ToastState.SUCCESS);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userDataModel!.data!.name.toString();
        emailController.text = cubit.userDataModel!.data!.email.toString();
        phoneController.text = cubit.userDataModel!.data!.phone.toString();

        return ConditionalBuilder(
          condition:
              state is! ShopGetUserDataLoading || cubit.userDataModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultTextFormField(
                        controller: nameController,
                        prefixIcon: const Icon(Icons.person_outline),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                          controller: phoneController,
                          prefixIcon: const Icon(Icons.phone_outlined),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty ';
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.upDateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'UPDATE',
                        color: defaultAppColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                        onPressed: () {
                          logout(context);
                        },
                        text: 'LOGOUT',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
