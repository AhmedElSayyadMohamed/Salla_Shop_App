import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/presentation_layer/layout/shop_layout.dart';
import 'package:shop_app/presentation_layer/modules/home/home.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_bloc/cubit.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_bloc/states.dart';
import 'package:shop_app/presentation_layer/modules/user/register/register.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class Login_screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is success_State) {
              if (state.loginModel.status!) {
                // print(state.loginModel.data!.name);
                // print(state.loginModel.data!.token);
                CachHelper.setData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  //ShopCubit.get(context).bottomNavBarIndex = 0;
                  navigatePushANDRemoveRout(
                    context: context,
                    navigateTo: ShopLayout(),
                  );
                });
              } else {
                showToast(
                  message: state.loginModel.message!,
                  state: ToastState.ERROR,
                );
                print(state.loginModel.message);
              }
            }
          },
          builder: (context, state) {
            var cubit = ShopLoginCubit.get(context);
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
                            'LOGIN',
                            style: fontAppStyle.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'login now to brows our hot offers ',
                            style: fontAppStyle.copyWith(
                                fontSize: 20, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
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
                            height: 15,
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
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! loading_State &&
                                state is! error_State,
                            builder: (context) => defaultButton(
                              onPressed: () {
                                print(emailController.text);
                                print(passwordController.text);
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).getHomeData();
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              text: 'login',
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ? ',
                                style:
                                    fontAppStyle.copyWith(color: Colors.grey),
                              ),
                              defaultTextButton(
                                onPressed: () {
                                  navigatePushTo(
                                      context: context,
                                      navigateTo: RegisterScreen());
                                },
                                child: Text(
                                  'Register Now',
                                  style: fontAppStyle.copyWith(
                                    color: defaultAppColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
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
