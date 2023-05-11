abstract class NewsStates {}
 class NewsInitialState extends NewsStates{}
 class NewsBottomNavState extends NewsStates{}
 class NewsLoadingState extends NewsStates{}
 class NewsGetBusinessDataSuccessState extends NewsStates{}
class NewsGetBusinessDataErrorState extends NewsStates {
 final String error ;
  NewsGetBusinessDataErrorState(this.error);
}