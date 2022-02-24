import 'package:shop_app/presentation_layer/models/change_to_favourite_model/change_to_favourite_model.dart';
import 'package:shop_app/presentation_layer/models/login_model/login_model.dart';

abstract class ShopStates {}

class InitialState extends ShopStates {}

class changeBottomNavBarIndexState extends ShopStates {}

class shop_home_loading extends ShopStates {}

class shop_home_success extends ShopStates {}

class shop_home_error extends ShopStates {}

class ShopCategoriesLoading extends ShopStates {}

class ShopCategoriesSuccess extends ShopStates {}

class ShopCategoriesError extends ShopStates {}

class ChangeItemToFavoriteState extends ShopStates {}

class ShopChangeFavouriteSuccess extends ShopStates {}

class ShopFavouriteSuccess extends ShopStates {
  final ChangeToFavouriteModel? favouriteModel;
  ShopFavouriteSuccess(this.favouriteModel);
}

class ShopFavouriteError extends ShopStates {}

class ShopGetFavouriteLoading extends ShopStates {}

class ShopGetFavouriteSuccess extends ShopStates {}

class ShopGetFavouriteError extends ShopStates {}

class ShopGetUserDataLoading extends ShopStates {}

class ShopGetUserDataSuccess extends ShopStates {
  final ShopLoginModel? userDataModel;
  ShopGetUserDataSuccess(this.userDataModel);
}

class ShopGetUserDataError extends ShopStates {}

class ShopGetUpdateUserDataLoading extends ShopStates {}

class ShopGetUpdateUserDataSuccess extends ShopStates {
  final ShopLoginModel? userDataModel;
  ShopGetUpdateUserDataSuccess(this.userDataModel);
}

class ShopGetUpdateUserDataError extends ShopStates {}
