// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/login/cubit/cubit.dart';
import 'package:flutter_application_1/modules/login/cubit/states.dart';
import 'package:flutter_application_1/modules/profile/profile.dart';
import 'package:flutter_application_1/modules/update/update.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:flutter_application_1/shared/style/icon_broken.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:iconsax/iconsax.dart';
import '../../layout/safari_app/cubit/statrs.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constantes.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';
import '../setting/setting.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getProfile(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SafariSuccessState) {}
        },
        builder: (context, state) {
          // var model = LoginCubit.get(context).model!.data!.firstName;
          return Scaffold(
            backgroundColor: defaultColor2,
            body: ConditionalBuilder(
              condition: LoginCubit.get(context).profileModel != null,
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (BuildContext context) {
                return SafeArea(
                  child: Column(children: [
                    IconButton(
                        onPressed: () {
                          ZoomDrawer.of(context)!.close();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                        ),
                        Positioned(
                          bottom: 90,
                          left: 20,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                LoginCubit.get(context)
                                    .profileModel!
                                    .data!
                                    .profilepicture
                                    .toString()),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 20,
                          child: Text(
                            LoginCubit.get(context)
                                .profileModel!
                                .data!
                                .name
                                .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ConditionalBuilder(
                          condition:
                              LoginCubit.get(context).profileModel != null,
                          fallback: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (BuildContext context) {
                            return Positioned(
                              bottom: 20,
                              left: 20,
                              child: Text(
                                LoginCubit.get(context)
                                    .profileModel!
                                    .data!
                                    .email
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: myDivider(),
                    ),

                    InkWell(
                      onTap: () {
                        navigateTo(context, ProfileScreen());
                      },
                      child: deffaultListTitle(
                          icon: Iconsax.profile_circle,
                          title: 'Profile',
                          colorText: Colors.white,
                          colorIcon: Colors.white),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     navigateTo(context, SettingScreen());
                    //   },
                    //   child: deffaultListTitle(
                    //       icon: Iconsax.setting_25,
                    //       title: 'Settings',
                    //       colorText: Colors.white,
                    //       colorIcon: Colors.white),
                    // ),

                    InkWell(
                      onTap: () {
                        navigateTo(
                            context,
                            UpdateScreen(
                              name: LoginCubit.get(context).firetName,
                            ));
                      },
                      child: deffaultListTitle(
                          icon: Icons.edit,
                          title: 'Edit Profile',
                          colorText: Colors.white,
                          colorIcon: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, SettingScreen());
                      },
                      child: deffaultListTitle(
                          icon: Icons.settings,
                          title: 'Settings',
                          colorText: Colors.white,
                          colorIcon: Colors.white),
                    ),
                    Spacer(),
                    myDivider(),
                    InkWell(
                      onTap: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          navigateAndFinish(context, LoginScreen());
                        });
                      },
                      child: deffaultListTitle(
                          icon: Icons.logout,
                          title: 'Logout',
                          colorText: Colors.white,
                          colorIcon: Colors.white),
                    ),
                  ]),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildDrawer(
    context,
  ) =>
      Drawer(
          child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
              ),
              Positioned(
                bottom: 90,
                left: 20,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHIr5vlCgOluC_uFO2vLrcfyuQv0iuvu7lPQ&usqp=CAU'),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 20,
                child: Text(
                  '$name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  '$email',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          myDivider(),
          InkWell(
              onTap: () {
                navigateTo(context, SettingScreen());
              },
              child: deffaultListTitle(
                  icon: IconBroken.setting, title: 'Settings')),
          Spacer(),
          myDivider(),
          InkWell(
            onTap: () {
              CacheHelper.removeData(key: 'token').then((value) {
                navigateAndFinish(context, LoginScreen());
              });
            },
            child: deffaultListTitle(icon: IconBroken.logout, title: 'Logout'),
          ),
        ],
      ));
}
