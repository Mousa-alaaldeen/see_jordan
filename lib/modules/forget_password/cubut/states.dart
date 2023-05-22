import '../../../models/forget_pass_model.dart';

abstract class ForgetPassState {}

class ForgetPassInitialState extends ForgetPassState {}

class ForgetPassLodingState extends ForgetPassState {}

class ForgetPassSuccessState extends ForgetPassState {
  final ForgetPassModel model;
  ForgetPassSuccessState(this.model);
}

class ForgetPassErrorState extends ForgetPassState {
  final Map<String, dynamic> error;
  ForgetPassErrorState(this.error);
}
