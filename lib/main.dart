import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/presentation_layer/layout/shop_layout.dart';
import 'package:shop_app/presentation_layer/modules/boarding/onbourding_screen.dart';
import 'package:shop_app/presentation_layer/modules/user/login/login_screen.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/theme/theme.dart';
import 'package:shop_app/web_services/dio_heloper.dart';
import 'data_layer/bloc_observer/bloc_observer.dart';


// hunter change //
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  var boarding = CachHelper.getData(key: 'onboard');
  token = CachHelper.getData(key: 'token');
  Widget startApp;
  print(token);
  print(boarding);
  if (boarding != null) {
    if (token != null) {
      startApp = const ShopLayout();
    } else {
      startApp = Login_screen();
    }
  } else {
    startApp = onbourding_screen();
  }

  ///////////runApp()//////////////

  runApp(MyApp(startApp: startApp));
}

class MyApp extends StatelessWidget {
  final Widget startApp;

  const MyApp({Key? key, required this.startApp}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: startApp,
      ),
    );
  }
}
