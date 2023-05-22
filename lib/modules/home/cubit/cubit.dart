// ignore_for_file: avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter_application_1/modules/home/cubit/states.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';

import '../../../models/data_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<Data> categories = [];
  List<bool> categoriesSelectedItm = [];
  CategoryModel? categoryModel;
  Data? data;
  int len = 0;
  void getCategories() {
    emit(GetCategoriesLodingState());
    DioHelper.getData(
      token: 'Bearer $token',
      url: 'Categories/allcategory',
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      //  data = Data.fromJson(value.data['data']);
      print('--------------------------------');
      // print(data!.name![0]);
      len = categoryModel!.data!.length;
      print(categoryModel!.data!.length);
      print('--------------------------------');
      // print(value.data['data'][0]['name']);
      // categories = value.data['data'];
      // for (var element in categories) {
      //   print(element.data);
      // }
      // print(value.data['data']);
      for (var e in value.data['data']) {
        categories.add(Data.fromJson(e));
      }
      // print(categories);

      // print('length');
      // print(categories.length);
      // print(value.data['data'][0]['categoryItems'][0]['title']);
      //  print(categories[0]['categoryItems'][0]['id']);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      //emit(GetCategoriesErrorState(error));
    });
  }

  int x = 0;

  void changeindex({required int z}) {
    x = z;
    print(x);
    emit(ChangeSelectedItmextends());
  }
}
