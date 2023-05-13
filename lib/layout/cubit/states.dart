abstract class NewsStates {}
 class NewsInitialState extends NewsStates{}
 class NewsBottomNavState extends NewsStates{}
 class NewsGetBusinessLoadingState extends NewsStates{}
 class NewsGetBusinessDataSuccessState extends NewsStates{}
class NewsGetBusinessDataErrorState extends NewsStates {
 final String error ;
  NewsGetBusinessDataErrorState(this.error);
}