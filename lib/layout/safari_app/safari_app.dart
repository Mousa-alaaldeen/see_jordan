// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, missing_required_param

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/login/login_screen.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import '../../modules/setting/setting.dart';
import 'cubit/cubit.dart';
import 'cubit/statrs.dart';

class SafariScreen extends StatelessWidget {
  const SafariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SafariCubit(),
        child: BlocConsumer<SafariCubit, SafariState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SafariCubit.get(context);

            return Scaffold(
              body: cubit.bottomScreen[cubit.carrentIndex],
              bottomNavigationBar: NavigationBar(
                shadowColor: Colors.amber,
                surfaceTintColor: Colors.cyanAccent,
                elevation: 20,
                backgroundColor: Colors.white,
                destinations: cubit.bottom,
                selectedIndex: cubit.carrentIndex,
                onDestinationSelected: (index) {
                  cubit.changeBottom(index);
                },
              ),
            );
          },
        ));
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
              child:
                  deffaultListTitle(icon: Icons.settings, title: 'Settings')),
          Spacer(),
          myDivider(),
          InkWell(
            onTap: () {
              CacheHelper.removeData(key: 'token').then((value) {
                navigateAndFinish(context, LoginScreen());
              });
            },
            child: deffaultListTitle(icon: Icons.logout, title: 'Logout'),
          ),
        ],
      ));
}//'2B8B4D'
              // bottomNavigationBar: GNav(
                
              //   gap: 8,
              //   color: Colors.grey,
              //   activeColor: HexColor('2B8B5D'),
              //   backgroundColor: Colors.white,
              //   tabs: [
              //     GButton(
              //       icon: Icons.home,
              //       text: 'hom',
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //       text: 'hom',
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //       text: 'hom',
              //     ),
              //     GButton(
              //       icon: Icons.home,
              //     )
              //   ],
              // ),
         
