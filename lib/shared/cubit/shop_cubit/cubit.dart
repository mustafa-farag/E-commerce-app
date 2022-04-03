import 'package:apiproject/models/shop_models/categories_model.dart';
import 'package:apiproject/models/shop_models/change_favorites_model.dart';
import 'package:apiproject/models/shop_models/get_favorites_model.dart';
import 'package:apiproject/models/shop_models/home_data.dart';
import 'package:apiproject/models/shop_models/profile_model.dart';
import 'package:apiproject/models/shop_models/search_product.dart';
import 'package:apiproject/models/shop_models/user_data.dart';
import 'package:apiproject/modules/shop_app_screen/categories/categories_screen.dart';
import 'package:apiproject/modules/shop_app_screen/favorites/favorites_screen.dart';
import 'package:apiproject/modules/shop_app_screen/home/home_screen.dart';
import 'package:apiproject/modules/shop_app_screen/settings/settings_screen.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/network/ending_points.dart';
import 'package:apiproject/shared/network/remote/dio_helper.dart';
import 'package:apiproject/shared/styles/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  FavoritesModel? favoritesModel;

  ChangeFavoritesModel? changeFavoritesModel;

  CategoriesModel? categoriesModel;

  HomeModel? homeModel;

  ProfileModel? profileData;

  SearchModel? searchModel;

  Map<int, bool> favorites = {};

  bool isShow = true;

  IconData suffix = Icons.visibility;

  List<Widget> shopScreens = [
    ShopHomeScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeIcon()
  {
    isShow = !isShow;
    suffix= isShow? Icons.visibility : Icons.visibility_off;
    emit(ChangeSuffixIconState());
  }

  void userLogin(
      {
        required String email,
        required String password,
      })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login,
        data:
        {
          'email': email,
          'password':password,
        }).then((value)
    {
      ShopLoginModel loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }

  void getHomeData() {
    emit(ShopLoadingGetDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(ShopSuccessGetDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetDataState());
    });
  }

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: getCategories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int? productId) {
    favorites[productId!] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: favorite,
        token: token,
        data: {
      'product_id': productId,
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
      url: favorite,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }

  void getProfileData() {
    emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      profileData = ProfileModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopSuccessGetProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileDataState());
    });
  }

  void updateProfileData({
  required String name,
  required String phone,
  required String email,
}) {
    emit(ShopLoadingUpdateProfileDataState());
    DioHelper.putData(
      url: updateProfileUrl,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      }
    ).then((value) {
      profileData = ProfileModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileDataState());
    });
  }

  void getSearchProduct(String text) {
    emit(ShopLoadingSearchProductState());
    DioHelper.postData(
        url: searchProduct,
        data: {
          'text':text,
        }).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchProductState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorSearchProductState());
    });
  }
}
