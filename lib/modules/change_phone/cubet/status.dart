// ignore_for_file: non_constant_identifier_names

import '../../../models/change_phone_model.dart';

abstract class ChangePhoneState {}

class ChangePhoneInitialState extends ChangePhoneState {}

class ChangePhoneLodingState extends ChangePhoneState {}

class ChangePhoneSuccessState extends ChangePhoneState {
  final ChangePhoneModel PhoneModel;
  ChangePhoneSuccessState(this.PhoneModel);
}

class ChangePhoneErrorState extends ChangePhoneState {}

class ChangePhonewordIsVisibilityState extends ChangePhoneState {}
