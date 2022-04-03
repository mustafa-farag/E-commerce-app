import 'package:animate_do/animate_do.dart';
import 'package:apiproject/layout/shop_layout/shop_layout_screen.dart';
import 'package:apiproject/modules/shop_app_screen/login/shop_login_screen.dart';
import 'package:apiproject/modules/shop_app_screen/register/cubit/states.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:apiproject/shared/styles/colors.dart';
import 'package:apiproject/shared/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.registerModel.status){
              CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token).then((value)
              {
                token = state.registerModel.data!.token;
                navigateAndFinish(context, ShopLoginScreen());
              });
              successToast(context ,state.registerModel.message );
              print(state.registerModel.message);
              print(state.registerModel.data!.token);
            }else {
              errorToast(context ,state.registerModel.message );
              print(state.registerModel.message);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BounceInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',
                          style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: defaultColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),),
                        const SizedBox(height: 5,),
                        Text(
                          'Fill in with your data',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontSize: 15,
                              color: defaultColor,
                              letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        defulttextformfeild(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'name',
                          prefix: Icons.person,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return'name is too short';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        defulttextformfeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'E-mail',
                            prefix: Icons.email,
                            validate: (value)
                            {
                              if(value!.isEmpty){
                                return 'email must not be empty';
                              }
                            }),
                        const SizedBox(height: 20,),
                        defulttextformfeild(
                          controller: passwordController,
                          type: TextInputType.phone,
                          label: 'Password',
                          prefix: Icons.lock,
                          isSecure:ShopRegisterCubit.get(context).isShow,
                          suffix:ShopRegisterCubit.get(context).suffix ,
                          suffixPresed: ()
                          {
                            ShopRegisterCubit.get(context).changeIcon();
                          },
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return'Password is too short';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        defulttextformfeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'phone',
                          prefix: Icons.phone,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return'phone is too short';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        button(
                          function: ()
                          {
                            if(formKey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'Register',
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
    );
  }
}
