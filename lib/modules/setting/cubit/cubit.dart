// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/modules/setting/cubit/states.dart';

import '../../../models/change_pass_model.dart';
import '../../../models/change_phone_model.dart';
import '../../../models/login_model.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingeIntialState());
  static SettingCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;

  void PasswordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(SettingPasswordIsVisibilityState());
  }

  LoginModel? mod;
  // void userSetting({
  //   required String firatName,
  //   required String lastName,
  //   required String email,
  //   required String phone,
  //   required String password,
  //   required String confirmPassword,
  // }) {
  //   emit(SettingLodingState());
  //   DioHelper.postData(url: 'Authentication/Setting', data: {
  //     'firstName': firatName,
  //     'lastName': lastName,
  //     'email': email,
  //     'phone': phone,
  //     'password': password,
  //     'confirmPassword': confirmPassword,
  //   }).then((value) {
  //     print('+++++');
  //     print('the Reg Is :${value.data}');
  //     SettingModel = SettingModel.fromJson(value.data);
  //     print('+++++');
  //     emit(SettingSuccessState(SettingModel!));
  //   }).catchError((error) {
  //     SettingModel = SettingModel.fromJson(error.response.data);
  //     print('888888888888888888888');
  //     print(SettingModel!.errorData);
  //     emit(
  //       SettingErrorState(error.response.data),
  //     );
  //   });
  // }
  bool isPasswordPhone = true;
  IconData iconDataPhone = Icons.remove_red_eye;
  void passwordVisibilityPhone() {
    isPasswordPhone = !isPasswordPhone;
    iconDataPhone = isPasswordPhone
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(ChangePhonewordIsVisibilityState());
  }

  ChangePhoneModel? changePhoneModel;

  void ChangePhone({
    required String phone,
    required String password,
  }) {
    emit(ChangePhoneLodingState());
    DioHelper.postData(
        token: 'Bearer $token',
        url: 'AccountAccess/changePhone',
        data: {
          'phoneNumber': phone,
          'password': password,
        }).then((value) {
      // print('+++++');
      print(value.data);
      changePhoneModel = ChangePhoneModel.fromJson(value.data);
      // print('+++++');
      emit(ChangePhoneSuccessState(changePhoneModel!));
    }).catchError((error) {
      print('888888888888888888888');

      print(error.toString());
      emit(
        ChangePhoneErrorState(),
      );
    });
  }

  ChangePhoneModel? emailModel;
  void ChangeEmail({
    required String email,
    required String password,
  }) {
    emit(ChangePhoneLodingState());
    DioHelper.postData(
        token: 'Bearer $token',
        url: 'AccountAccess/changeEmail',
        data: {
          'phoneNumber': email,
          'password': password,
        }).then((value) {
      // print('+++++');
      print(value.data);
      emailModel = ChangePhoneModel.fromJson(value.data);
      // print('+++++');
      emit(ChangeEmailSuccessState(emailModel!));
    }).catchError((error) {
      print('888888888888888888888');

      print(error.toString());
      emit(
        ChangeEmailErrorState(),
      );
    });
  }

  bool isPasswordchangepassword = true;
  IconData iconDatachangepassword = Icons.remove_red_eye;
  void passwordVisibilitychangepassword() {
    isPasswordchangepassword = !isPasswordchangepassword;
    iconDatachangepassword = isPasswordchangepassword
        ? iconDatachangepassword = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(ChangePasswordIsVisibilityState());
  }

  ChangePassModel? changePassModel;

  void ChangePass({
    required String currentPassword,
    required String confirmNewPassword,
    required String newPassword,
  }) {
    emit(ChangePassLodingState());
    DioHelper.postData(
        token: "Bearer $token",
        url: 'AccountAccess/changePassword',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        }).then((value) {
      changePassModel = ChangePassModel.fromJson(value.data);
      emit(ChangePassSuccessState(changePassModel!));
    }).catchError((error) {
      emit(
        ChangePassErrorState(),
      );
    });
  }
}
