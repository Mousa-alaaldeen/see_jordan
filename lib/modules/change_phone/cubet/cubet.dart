// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/modules/change_phone/cubet/status.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';

import '../../../models/change_phone_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit() : super(ChangePhoneInitialState());
  static ChangePhoneCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
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
      print('+++++');
      print(value.data);
      changePhoneModel = ChangePhoneModel.fromJson(value.data);
      print('+++++');
      emit(ChangePhoneSuccessState(changePhoneModel!));
    }).catchError((error) {
      print('888888888888888888888');

      print(error.toString());
      emit(
        ChangePhoneErrorState(),
      );
    });
  }
}
