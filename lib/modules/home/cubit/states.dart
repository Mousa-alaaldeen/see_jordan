abstract class HomeState {}

class HomeInitialState extends HomeState {}

class GetCategoriesLodingState extends HomeState {}

class GetCategoriesSuccessState extends HomeState {}

class GetCategoriesErrorState extends HomeState {
  final TypeError error;
  GetCategoriesErrorState(this.error);
}

class CategoriesSelectedItmextends extends HomeState {}

class ChangeSelectedItmextends extends HomeState {}

class GetProfileLodingState extends HomeState {}

class GetProfileSuccessState extends HomeState {}

class GetProfileErrorState extends HomeState {}
