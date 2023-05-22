// ignore_for_file: non_constant_identifier_names

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/change_passWord/cubet/status.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';

import '../../../models/change_pass_model.dart';

import '../../../shared/network/remote/dio_helper.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit() : super(ChangePassInitialState());
  static ChangePassCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
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
