// ignore_for_file: avoid_print

import 'package:cubit_form/cubit_form.dart';

import 'package:flutter_application_1/modules/forget_password/cubut/states.dart';

import '../../../models/forget_pass_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit() : super(ForgetPassInitialState());
  static ForgetPassCubit get(context) => BlocProvider.of(context);

  ForgetPassModel? forgetPassModel;

  void forgetPass({
    required String email,
  }) {
    emit(ForgetPassLodingState());
    DioHelper.postData(url: 'Authentication/forgetPassword', qury: {
      'email': email,
    }).then((value) {
      print('+++++');
      print(value.data);
      forgetPassModel = ForgetPassModel.fromJson(value.data);
      print('+++++');
      emit(ForgetPassSuccessState(forgetPassModel!));
    }).catchError((error) {
      forgetPassModel = ForgetPassModel.fromJson(error.response.data);
      print('888888888888888888888');

      emit(
        ForgetPassErrorState(error.response.data),
      );
    });
  }
}
