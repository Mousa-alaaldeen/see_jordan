// ignore_for_file: avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/register/cubit/states.dart';

import '../../../models/register_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegistereIntialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  // ignore: non_constant_identifier_names
  void PasswordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(RegisterPasswordIsVisibilityState());
  }

  RegisterModel? registerModel;
  List<RegisterModel> er = [];
  void userRegister({
    required String firatName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterLodingState());
    print('ee');
    DioHelper.postData(url: 'Authentication/register', data: {
      'firstName': firatName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'confirmPassword': confirmPassword,
    }).then((value) {
      print('+++++');
      print('the Reg Is :${value.data}');
      registerModel = RegisterModel.fromJson(value.data);
      print('+++++');
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      registerModel = RegisterModel.fromJson(error.response.data);
      print('888888888888888888888');
      print(registerModel!.errorData);
      emit(
        RegisterErrorState(error.response.data),
      );
    });
  }
}
