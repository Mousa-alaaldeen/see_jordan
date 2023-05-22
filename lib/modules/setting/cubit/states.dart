// ignore_for_file: non_constant_identifier_names

import '../../../models/change_pass_model.dart';
import '../../../models/change_phone_model.dart';

abstract class SettingStates {}

class SettingeIntialState extends SettingStates {}

class SettingLodingState extends SettingStates {}

class SettingSuccessState extends SettingStates {
  // final SettingModel model;
  // SettingSuccessState(this.model);
}

class SettingErrorState extends SettingStates {
  final Map<String, dynamic> error;
  SettingErrorState(this.error);
}

class SettingPasswordIsVisibilityState extends SettingStates {}

class ChangePhoneLodingState extends SettingStates {}

class ChangePhoneSuccessState extends SettingStates {
  final ChangePhoneModel PhoneModel;
  ChangePhoneSuccessState(this.PhoneModel);
}

class ChangePhoneErrorState extends SettingStates {}

class ChangeEmailSuccessState extends SettingStates {
  final ChangePhoneModel emailModel;
  ChangeEmailSuccessState(this.emailModel);
}

class ChangeEmailErrorState extends SettingStates {}

class ChangePhonewordIsVisibilityState extends SettingStates {}
//password

class ChangePassLodingState extends SettingStates {}

class ChangePassSuccessState extends SettingStates {
  final ChangePassModel passModel;
  ChangePassSuccessState(this.passModel);
}

class ChangePassErrorState extends SettingStates {}

class ChangePasswordIsVisibilityState extends SettingStates {}
