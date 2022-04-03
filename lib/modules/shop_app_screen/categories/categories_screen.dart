import 'package:apiproject/models/shop_models/categories_model.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>categoriesBuilder(ShopCubit.get(context).categoriesModel?.data!.data[index]),
            separatorBuilder: (context,index) => Devider(),
            itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }
  Widget categoriesBuilder(DataModel? model) =>  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            placeholderScale: 1.2,
            placeholderFit: BoxFit.none,
            image:model!.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            imageErrorBuilder: (context,error,stackTrace){
              return Image.asset("assets/images/error.jpeg",scale:2 ,);
            }),
        const SizedBox(width: 10,),
        Text(
          model.name,
          style:const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: (){},
            icon:const Icon(Icons.arrow_forward_ios_outlined))
      ],
    ),
  );
}
