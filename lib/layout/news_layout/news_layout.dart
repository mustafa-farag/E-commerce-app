import 'package:apiproject/modules/news_app_screen/search/search_screen.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/news_cubit/states.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,states){} ,
      builder: (context,states)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:const Text('news app'),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon:const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).changeTheme();
                },
                icon:const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBarState(index);
            },
            items: cubit.bottomItems,
          ) ,
        );
      },
    );
  }
}
