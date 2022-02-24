import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation_layer/layout/shop_layout.dart';
import 'package:shop_app/presentation_layer/modules/home/home.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_bloc/cubit.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_bloc/states.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_screen.dart';
import 'package:shop_app/presentation_layer/modules/user/register/register_cubit/register_cubit.dart';
import 'package:shop_app/presentation_layer/modules/user/register/register_cubit/register_state.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigatePushTo(context: context, navigateTo: Login_screen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.registerModel!.status!) {
                // print(state.loginModel.data!.name);
                // print(state.loginModel.data!.token);
                CachHelper.setData(
                        key: 'token', value: state.registerModel!.data!.token)
                    .then((value) {
                  token = state.registerModel!.data!.token;

                  navigatePushANDRemoveRout(
                    context: context,
                    navigateTo: const ShopLayout(),
                  );
                });
              } else {
                showToast(
                  message: state.registerModel!.message!,
                  state: ToastState.ERROR,
                );
                print(state.registerModel!.message);
              }
            }
          },
          builder: (context, state) {
            var cubit = ShopRegisterCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: fontAppStyle.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'register now to browse our hot offers ',
                            style: fontAppStyle.copyWith(
                                fontSize: 20, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            prefixIcon: const Icon(Icons.person_outline),
                            labelText: 'UserName',
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
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address must not be empty ';
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
                              labelText: 'UserPhone',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'phone must not be empty ';
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextFormField(
                            controller: passwordController,
                            obscureText: cubit.obSecure,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.visibleEyeOrNot();
                              },
                              icon: cubit.suffix,
                            ),
                            labelText: 'Password',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is very short';
                              }
                            },
                            onSubmite: (value) {
                              print(emailController.text);
                              print(passwordController.text);
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  userPhone: phoneController.text,
                                  username: nameController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState &&
                                state is! RegisterErrorState,
                            builder: (context) => defaultButton(
                              onPressed: () {
                                print(emailController.text);
                                print(passwordController.text);
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    userPhone: phoneController.text,
                                    username: nameController.text,
                                  );

                                  token = cubit.registerModel!.data!.token;

                                  navigatePushANDRemoveRout(
                                      context: context,
                                      navigateTo: const ProductScreen());
                                }
                              },
                              isUpperCase: true,
                              text: 'register',
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
