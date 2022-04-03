import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
   ShopSearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defulttextformfeild(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'search',
                      prefix: Icons.search,
                      onChange: (value){
                          ShopCubit.get(context).getSearchProduct(value);
                      },
                      validate: (value){
                        if(value!.isEmpty){
                          return 'search field can not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10,),
                  if(state is ShopLoadingSearchProductState)
                   const LinearProgressIndicator(),
                  const SizedBox(height: 10,),
                  if(state is ShopSuccessSearchProductState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildSearchItem(ShopCubit.get(context).searchModel!.data!.data![index], context),
                        separatorBuilder: (context, index) => Devider(),
                        itemCount: ShopCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
