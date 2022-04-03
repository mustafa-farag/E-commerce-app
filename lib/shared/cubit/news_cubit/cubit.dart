
import 'package:apiproject/modules/news_app_screen/busniess/busniess_screen.dart';
import 'package:apiproject/modules/news_app_screen/science/science_screen.dart';
import 'package:apiproject/modules/news_app_screen/sports/sports_screen.dart';
import 'package:apiproject/shared/cubit/news_cubit/states.dart';
import 'package:apiproject/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon:Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon:Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label: 'Sports',
    ),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];
  void changeNavBarState(int index)
  {
    currentIndex = index;
    if(currentIndex == 1) {
      getSportsData();
    }
    if(currentIndex == 2) {
      getScienceData();
    }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business=[];

  void getBusinessData()
  {
    emit(NewsGetBusinessDataLoadingState());
    if(business.isEmpty)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value)
      {
        business=value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessDataSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetBusinessDataErrorState(error));
      });
    } else
    {
      emit(NewsGetBusinessDataSuccessState());
    }
  }

  List<dynamic> sports=[];

  void getSportsData()
  {
    emit(NewsGetSportsDataLoadingState());
    if(sports.isEmpty)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value)
      {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsDataSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsDataErrorState(error));
      });
    }else
    {
      emit(NewsGetSportsDataSuccessState());
    }

  }

  List<dynamic> science=[];

  void getScienceData()
  {
    emit(NewsGetScienceDataLoadingState());
    if(science.isEmpty)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
          }
      ).then((value)
      {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceDataSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceDataErrorState(error));
      });
    } else
    {
      emit(NewsGetScienceDataSuccessState());
    }

  }

  List<dynamic> search=[];

  void getSearch(value)
  {
    emit(NewsGetSearchDataLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
        }
    ).then((value)
    {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchDataErrorState(error));
    });

  }

}