// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/style/icon_broken.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Text(
          'See Jordan',
          style: GoogleFonts.abrilFatface()
              .copyWith(fontSize: 25, color: Colors.black),
        ),
        actions: const [
          Icon(
            IconBroken.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            IconBroken.notification,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Icon(
                  IconBroken.heart,
                  size: 200,
                ),
              ),
              Text('Dont have favorite'),
            ],
          ),
        ),
      ),
    );
  }
}
