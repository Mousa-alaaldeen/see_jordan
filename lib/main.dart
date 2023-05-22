// ignore_for_file: prefer_const_constructors, unused_local_variable, must_be_immutable, deprecated_member_use, dead_code, avoid_print
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/zoom_drawer/zoom_drawer.dart';
import 'package:flutter_application_1/shared/bloc.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/style/theme.dart';
import 'package:flutter_application_1/weather/providers/weather_provider.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/cubit/states.dart';
import 'modules/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    await CacheHelper.init();
    token = CacheHelper.getData(key: 'token');
    name = CacheHelper.getData(key: 'name');
    email = CacheHelper.getData(key: 'email');
    userId = CacheHelper.getData(key: 'userId');
    image = CacheHelper.getData(key: 'image');

    bool? onBording = CacheHelper.getData(key: 'onBording');

    print('token:$token');
    print(onBording);
    print('onnn');
    // print(onBording);
    Widget widget;
    if (token != null) {
      widget = ZoomDrawe();
    } else {
      widget = LoginScreen();
    }

    runApp(ChangeNotifierProvider(
        create: (context) {
          return WeatherProvider();
        },
        child: MyApp(
          // onBording: onBording!,
          startWidget: widget,
        )));
    Bloc.observer = MyBlocObserver();
  });
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    super.key,
    required this.startWidget,
  });
  // final bool onBording;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LoginCubit()
                ..getPosts()
                ..getProfile())
        ],
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: startWidget,
                theme: lightTheme);
          },
        ),
      ),
    );
  }
}
