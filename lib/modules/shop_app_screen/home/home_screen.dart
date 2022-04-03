


import 'package:apiproject/models/shop_models/categories_model.dart';
import 'package:apiproject/models/shop_models/home_data.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:apiproject/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopSuccessChangeFavoritesState)
          {
            if(!state.model.status) {
              errorToast(context, state.model.message);
            }
          }
        },
        builder: (context,state){

          if( ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null){
            return Scaffold(
              appBar: AppBar(),
              body: productBuilder(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel , context),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body:const Center(child: CircularProgressIndicator()),
          );
        },
    );
  }
  Widget productBuilder(HomeModel? model , CategoriesModel? categoriesModel , context)
  {
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items:model?.data?.banners.map((e) => FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    placeholderScale: 1.2,
                    placeholderFit: BoxFit.none,
                    image:e.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context,error,stackTrace){
                      return Image.asset("assets/images/error.jpeg",scale:2 ,);
                    }),).toList() ,
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                viewportFraction: 1.0,

              ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context , index) => buildCategoriesItem(categoriesModel?.data!.data[index]),
                      separatorBuilder: (context , index) => const SizedBox(width: 10,),
                      itemCount:categoriesModel!.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              childAspectRatio: 1/1.72,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 2,
              children: List.generate(
                    model!.data!.products.length,
                    (index)=>buildGridProducts(model.data!.products[index] , context),
            ),
            ),
          )
  ]
      ),
    );
  }
  Widget buildCategoriesItem(DataModel? model) =>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading.gif',
          placeholderScale: 1.2,
          placeholderFit: BoxFit.none,
          image:model!.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          imageErrorBuilder: (context,error,stackTrace){
            return Image.asset("assets/images/error.jpeg",scale:2 ,);
          }),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    ],
  ) ;
  Widget buildGridProducts(ProductsModel model , context) =>  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                placeholderScale: 1.2,
                placeholderFit: BoxFit.none,
                image:model.image!,
                width: double.infinity,
                height: 200,
                imageErrorBuilder: (context,error,stackTrace){
                  return Image.asset("assets/images/error.jpeg",scale:2 ,);
                }),
            if(model.discount !=0)
             Container(
              padding:const EdgeInsets.all(3),
              color: Colors.red,
              child:const Text(
                'DISCOUNT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  '${model.name}',
                style:const TextStyle(
                  fontSize: 14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                      '${model.price}',
                    style:const TextStyle(
                      color: defaultColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if(model.discount !=0)
                    Text(
                      '${model.oldPrice}',
                      style:const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon:const Icon(Icons.favorite_border),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
