import 'package:animate_do/animate_do.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSettingsScreen extends StatelessWidget {
   ShopSettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        nameController.text = ShopCubit.get(context).profileData!.data!.name! ;
        emailController.text = ShopCubit.get(context).profileData!.data!.email! ;
        phoneController.text = ShopCubit.get(context).profileData!.data!.phone! ;

        if(state is ShopLoadingGetProfileDataState){
          return const Center(child: CircularProgressIndicator());
        }else{
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateProfileDataState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 20,),
                      defulttextformfeild(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'name',
                        prefix: Icons.person,
                        validate: (value)
                        {
                          if(value!.isEmpty){
                            return 'name field can not be empty';
                          }
                          return null;
                        },),
                      const SizedBox(
                        height: 20,
                      ),
                      defulttextformfeild(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'email address',
                        prefix: Icons.email,
                        validate: (value)
                        {
                          if(value!.isEmpty){
                            return 'email field can not be empty';
                          }
                          return null;
                        },),
                      const SizedBox(
                        height: 20,
                      ),
                      defulttextformfeild(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'phone',
                        prefix: Icons.phone,
                        validate: (value)
                        {
                          if(value!.isEmpty){
                            return 'phone field can not be empty';
                          }
                          return null;
                        },),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).updateProfileData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text
                              );
                            }
                          },
                          color: Colors.green,
                          text: 'Update'),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                          function: (){
                            logout(context);
                          },
                          color: Colors.red,
                          text: 'SignOut'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
