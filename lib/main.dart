import 'package:apiproject/layout/shop_layout/shop_layout_screen.dart';
import 'package:apiproject/modules/shop_app_screen/login/shop_login_screen.dart';
import 'package:apiproject/modules/shop_app_screen/onboard_screen/onboarding_screen.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/states.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:apiproject/shared/network/remote/dio_helper.dart';
import 'package:apiproject/shared/styles/constant.dart';
import 'package:apiproject/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();

  var isDark = CacheHelper.getData(key: 'isDark');
  token = CacheHelper.getData(key: 'token');
  var onBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget widget ;

    if(onBoarding != null)
    {
      if(token != null) {
        widget = const ShopLayoutScreen();
      } else {
        widget = ShopLoginScreen();
      }
    }else {
      widget = OnBoardingScreen();
    }

  runApp(MyApp(isDark: isDark,startWidget: widget,));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget startWidget;
  MyApp({this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusinessData(),),
        BlocProvider(create: (context)=> AppCubit()..changeTheme(fromShared: isDark),),
        BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData()),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          ) ;
        },
      ),
    );
  }
}
