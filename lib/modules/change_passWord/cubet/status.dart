// ignore_for_file: non_constant_identifier_names

import '../../../models/change_pass_model.dart';

abstract class ChangePassState {}

class ChangePassInitialState extends ChangePassState {}

class ChangePassLodingState extends ChangePassState {}

class ChangePassSuccessState extends ChangePassState {
  final ChangePassModel passModel;
  ChangePassSuccessState(this.passModel);
}

class ChangePassErrorState extends ChangePassState {}

class ChangePasswordIsVisibilityState extends ChangePassState {}
