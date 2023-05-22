// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 2.0,
    titleTextStyle: TextStyle(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      // statusBarIconBrightness: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: HexColor('2b5c62'),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // backgroundColor: Colors.grey.shade200,
    elevation: 2.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor2,
    focusColor: defaultColor2,
  ),
);
