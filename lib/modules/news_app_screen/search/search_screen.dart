import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/news_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defulttextformfeild(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  validate: (value)
                  {
                    if(value!.isEmpty){
                      return 'search can not be empty';
                    }
                    return null ;
                  },
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),

              Expanded(child: articleBuilder(list, context)),
            ],
          ),
        );
      },
    );
  }
}
