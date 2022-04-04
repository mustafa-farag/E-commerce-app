import 'package:animate_do/animate_do.dart';
import 'package:apiproject/layout/shop_layout/shop_layout_screen.dart';
import 'package:apiproject/modules/shop_app_screen/register/shop_register_screen.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:apiproject/shared/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
              {
                token = state.loginModel.data!.token;
                ShopCubit.get(context).getProfileData();
                ShopCubit.get(context).getFavoritesData();
                navigateAndFinish(context, const ShopLayoutScreen());
              });
              successToast(context ,state.loginModel.message );
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
            }else {
              errorToast(context ,state.loginModel.message );
              print(state.loginModel.message);
            }
          }
        },
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 1500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome !',
                            style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2 ,
                            ),),
                          const SizedBox(height: 5,),
                          Text(
                            'Sign In To Continue !',
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                fontSize: 15,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30,),
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
                            isSecure:cubit.isShow,
                            suffix:cubit.suffix ,
                            onSubmit: (value)
                            {
                              if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixPresed: ()
                            {
                              cubit.changeIcon();
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
                          button(
                            function: ()
                            {
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Login',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                  onPressed: ()
                                  {
                                    navigateTo(context, ShopRegisterScreen());
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}
