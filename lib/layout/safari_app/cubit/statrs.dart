import '../../../models/login_model.dart';

abstract class SafariState {}

class SafariInitialState extends SafariState {}

class SafariLodingState extends SafariState {}

class SafariSuccessState extends SafariState {
  final LoginModel model;
  SafariSuccessState(this.model);
}

class SafariErrorState extends SafariState {
  final String error;
  SafariErrorState(this.error);
}

class SafariPasswordIsVisibilityState extends SafariState {}

class ChangeBottomNavState extends SafariState {}
