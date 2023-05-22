// ignore_for_file: prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/layout/safari_app/safari_app.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../layout/safari_app/cubit/cubit.dart';
import '../../layout/safari_app/cubit/statrs.dart';
import '../menu_page/menu_page.dart';

class ZoomDrawe extends StatelessWidget {
  const ZoomDrawe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SafariCubit(),
      child: BlocConsumer<SafariCubit, SafariState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ZoomDrawer(
              slideWidth: 350.0,
              borderRadius: 30.0,
              mainScreen: SafariScreen(),
              menuScreen: MenuPage(),
            ),
          );
        },
      ),
    );
  }
}
