import 'package:apiproject/models/shop_models/user_data.dart';
import 'package:apiproject/modules/shop_app_screen/register/cubit/states.dart';
import 'package:apiproject/shared/network/ending_points.dart';
import 'package:apiproject/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isShow = true;
  IconData suffix = Icons.visibility;

  void changeIcon()
  {
    isShow = !isShow;
    suffix= isShow? Icons.visibility : Icons.visibility_off;
    emit(ChangeRegisterSuffixIconState());
  }

  void userRegister(
      {
        required String email,
        required String password,
        required String name,
        required String phone,
      })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: register,
        data:
        {
          'email': email,
          'password':password,
          'name':name,
          'phone':phone,
        }).then((value)
    {
      ShopLoginModel registerModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}