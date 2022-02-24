import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/models/categories_model/categories_model.dart';
import 'package:shop_app/presentation_layer/models/change_to_favourite_model/change_to_favourite_model.dart';
import 'package:shop_app/presentation_layer/models/favourite_model/favourite_model.dart';
import 'package:shop_app/presentation_layer/models/home_model/home_model.dart';
import 'package:shop_app/presentation_layer/models/login_model/login_model.dart';
import 'package:shop_app/presentation_layer/modules/categories/category.dart';
import 'package:shop_app/presentation_layer/modules/favorites/favorite.dart';
import 'package:shop_app/presentation_layer/modules/home/home.dart';
import 'package:shop_app/presentation_layer/modules/settings/setting.dart';
import 'package:shop_app/presentation_layer/shared/constants/constant.dart';
import 'package:shop_app/web_services/dio_heloper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  //////////////variable//////////////
  int bottomNavBarIndex = 0;
  bool isSearch = false;
  List<BottomNavigationBarItem> bottomNavBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps_outlined),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outlined),
      label: 'Favourites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];
  List<Widget> screens = [
    ProductScreen(),
    category(),
    Favourite(),
    Setting(),
  ];

///////////////methods///////////////

  void bottomNavigationBarIndex(int index) {
    bottomNavBarIndex = index;
    if (index == 0) getHomeData();
    if (index == 1) getCategoriesData();
    if (index == 2) getFavouriteData();

    emit(changeBottomNavBarIndexState());
  }

  HomeModel? homeModel;
  CategoryModel? categoryModel; //CategoryModel
  ChangeToFavouriteModel? changeFavouriteModel;
  FavouriteModel? favouriteModel;
  ShopLoginModel? userDataModel;
  Map<int, bool> favourite = {};
//////////////////////////////////////
  void getHomeData() {
    emit(shop_home_loading());
    DioHelper.getData(
      url: Home,
      lang: 'en',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favourite.addAll({element.id: element.inFavorites});
      });
      //print(favourite);
      emit(shop_home_success());
    }).catchError((error) {
      print('error when get home data from api :${error.toString()}');
      emit(shop_home_error());
    });
  }

  void getCategoriesData() {
    emit(ShopCategoriesLoading());

    DioHelper.getData(url: categories, lang: 'en', token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      //   print(categoryModel.data!.category[0].name);
      emit(ShopCategoriesSuccess());
    }).catchError((error) {
      print("error when get categories data ${error.toString()}");
      emit(ShopCategoriesError());
    });
  }

  void addOrDeleteItemFromFavourite(int productId) {
    favourite[productId] = !favourite[productId]!;

    //print(favourite[productId]);

    emit(ShopChangeFavouriteSuccess());

    DioHelper.postData(
      url: favourites,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      changeFavouriteModel = ChangeToFavouriteModel.fromJson(value.data);

      if (changeFavouriteModel!.status == false) {
        favourite[productId] = !favourite[productId]!;
      } else {
        getFavouriteData();
      }
      //print(value);
      emit(ShopFavouriteSuccess(changeFavouriteModel));
    }).catchError((error) {
      if (changeFavouriteModel!.status == false) {
        favourite[productId] = !favourite[productId]!;
      }
      print('error when add or delete to favourite : ' + error.toString());
      emit(ShopFavouriteError());
    });
  }

  void getFavouriteData() {
    emit(ShopGetFavouriteLoading());

    DioHelper.getData(url: favourites, token: token, lang: 'en').then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      print(favouriteModel!.data!.data[0].product!.name);
      emit(ShopGetFavouriteSuccess());
    }).catchError((error) {
      print("error when get favourite data :${error.toString()}");
      emit(ShopGetFavouriteError());
    });
  }

  void getUserData() {
    emit(ShopGetUserDataLoading());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccess(userDataModel));
    }).catchError((error) {
      print('error when get UserData from api : ${error.toString()}');
      emit(ShopGetUserDataError());
    });
  }

  void upDateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopGetUserDataLoading());
    DioHelper.putData(
      url: update,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccess(userDataModel));
    }).catchError((error) {
      print('error when get UserData from api : ${error.toString()}');
      emit(ShopGetUserDataError());
    });
  }
}
