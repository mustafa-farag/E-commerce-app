import 'package:apiproject/models/shop_models/user_data.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates
{
  late final String error;

  ShopRegisterErrorState(this.error);
}

class ChangeRegisterSuffixIconState extends ShopRegisterStates{}
