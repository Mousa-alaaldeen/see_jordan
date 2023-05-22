import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/safari_app/cubit/statrs.dart';
import 'package:flutter_application_1/modules/profile/profile.dart';
import 'package:icon_decoration/icon_decoration.dart';
import '../../../companies/companies.dart';
import '../../../modules/home/home.dart';
import '../../../modules/post/post.dart';
import '../../../shared/style/icon_broken.dart';

class SafariCubit extends Cubit<SafariState> {
  SafariCubit() : super(SafariInitialState());
  static SafariCubit get(context) => BlocProvider.of(context);
  List<Widget> bottom = [
    const NavigationDestination(
      icon: DecoratedIcon(
        icon: Icon(IconBroken.home),
        decoration: IconDecoration(
          shadows: [
            Shadow(
              blurRadius: 3,
              offset: Offset(3, 0),
            ),
          ],
        ),
      ),
      label: 'Home',
      selectedIcon: DecoratedIcon(
        icon: Icon(IconBroken.home),
        decoration: IconDecoration(
          shadows: [Shadow(blurRadius: 3, offset: Offset(3, 0))],
        ),
      ),
    ),
    const NavigationDestination(
      icon: Icon(IconBroken.moreCircle),
      label: 'Post',
      selectedIcon: Icon(IconBroken.moreCircle),
    ),
    const NavigationDestination(
      icon: DecoratedIcon(
        icon: Icon(Icons.bus_alert_outlined),
        decoration: IconDecoration(),
      ),
      label: 'Transport',
      selectedIcon: DecoratedIcon(
        icon: Icon(Icons.bus_alert_outlined),
        decoration: IconDecoration(),
      ),
    ),
    const NavigationDestination(
        icon: Icon(IconBroken.profile),
        label: 'Profile',
        selectedIcon: Icon(IconBroken.profile)),
  ];
  List<Widget> bottomScreen = [
    const HomeScreen(),
    const PostScreen(),
    const CompaniesScreen(),
    const ProfileScreen(),
  ];
  int carrentIndex = 0;
  void changeBottom(index) {
    carrentIndex = index;
    emit(ChangeBottomNavState());
  }
}
