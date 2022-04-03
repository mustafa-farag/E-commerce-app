import 'package:apiproject/models/shop_models/get_favorites_model.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopFavoritesScreen extends StatelessWidget {
  const ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        if(state is ShopLoadingGetFavoritesDataState){
          return const Center(child: CircularProgressIndicator());
        }else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildProductItem(ShopCubit.get(context).favoritesModel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => Devider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
          );
        }
      },
    );
  }
}
