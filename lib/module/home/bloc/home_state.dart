abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeSignedOut extends HomeState {}

class HomeError extends HomeState {
  final String errorMsg;

  HomeError(this.errorMsg);
}
