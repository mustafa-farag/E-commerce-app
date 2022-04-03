import 'package:apiproject/modules/shop_app_screen/login/shop_login_screen.dart';
import 'package:apiproject/modules/shop_app_screen/search/search_screen.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Panda House'),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, ShopSearchScreen());
                  },
                  icon:const Icon(Icons.search),
              ),
            ],
          ),
          body:cubit.shopScreens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap:(index) {
              cubit.changeNavBar(index);
            },
            items:const [
              BottomNavigationBarItem(
                icon:Icon( Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon( Icons.apps_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon:Icon( Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon:Icon( Icons.settings),
                label: 'Settings',
              ),

            ],
          ),
        ) ;
      },
    );
  }
}
