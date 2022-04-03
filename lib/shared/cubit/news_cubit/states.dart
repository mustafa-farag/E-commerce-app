abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavBarState extends NewsStates{}

class NewsGetBusinessDataLoadingState extends NewsStates{}

class NewsGetBusinessDataSuccessState extends NewsStates{}

class NewsGetBusinessDataErrorState extends NewsStates
{
  late final String error;

  NewsGetBusinessDataErrorState(this.error);

}

class NewsGetSportsDataLoadingState extends NewsStates{}

class NewsGetSportsDataSuccessState extends NewsStates{}

class NewsGetSportsDataErrorState extends NewsStates
{
  late final String error;

  NewsGetSportsDataErrorState(this.error);

}

class NewsGetScienceDataLoadingState extends NewsStates{}

class NewsGetScienceDataSuccessState extends NewsStates{}

class NewsGetScienceDataErrorState extends NewsStates
{
  late final String error;

  NewsGetScienceDataErrorState(this.error);

}

class NewsGetSearchDataLoadingState extends NewsStates{}

class NewsGetSearchDataSuccessState extends NewsStates{}

class NewsGetSearchDataErrorState extends NewsStates
{
  late final String error;

  NewsGetSearchDataErrorState(this.error);

}


