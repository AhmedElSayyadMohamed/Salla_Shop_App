import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

ThemeData darkMode = ThemeData();

ThemeData lightMode = ThemeData(
  primarySwatch: defaultAppColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    // selectedItemColor: default_color,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    elevation: 20,
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      size: 30,
    ),
    unselectedIconTheme: IconThemeData(
      size: 25,
    ),
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  )),
);
