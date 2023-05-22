import '../../../models/register_model.dart';

abstract class RegisterStates {}

class RegistereIntialState extends RegisterStates {}

class RegisterLodingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel model;
  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {
  final Map<String, dynamic> error;
  RegisterErrorState(this.error);
}

class RegisterPasswordIsVisibilityState extends RegisterStates {}
