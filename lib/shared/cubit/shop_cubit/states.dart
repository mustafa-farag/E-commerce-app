import 'package:apiproject/models/shop_models/change_favorites_model.dart';
import 'package:apiproject/models/shop_models/user_data.dart';

abstract class ShopStates {}

class ShopLoginSuccessState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopStates{}

class ShopLoginErrorState extends ShopStates
{
  late final String error;

  ShopLoginErrorState(this.error);
}

class ChangeSuffixIconState extends ShopStates{}


class ShopInitialState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}

class ShopLoadingGetDataState extends ShopStates{}

class ShopSuccessGetDataState extends ShopStates{}

class ShopErrorGetDataState extends ShopStates{}

class ShopLoadingCategoriesState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopLoadingChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
   late final ChangeFavoritesModel model ;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopLoadingGetFavoritesDataState extends ShopStates{}

class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopLoadingGetProfileDataState extends ShopStates{}

class ShopSuccessGetProfileDataState extends ShopStates{}

class ShopErrorGetProfileDataState extends ShopStates{}

class ShopLoadingUpdateProfileDataState extends ShopStates{}

class ShopSuccessUpdateProfileDataState extends ShopStates{}

class ShopErrorUpdateProfileDataState extends ShopStates{}

class ShopLoadingSearchProductState extends ShopStates{}

class ShopSuccessSearchProductState extends ShopStates{}

class ShopErrorSearchProductState extends ShopStates{}