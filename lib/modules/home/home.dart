// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_is_empty, avoid_unnecessary_containers

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/data_model.dart';
import 'package:flutter_application_1/modules/home/cubit/cubit.dart';
import 'package:flutter_application_1/modules/home/cubit/states.dart';
import 'package:flutter_application_1/weather/pages/home_page.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../shared/style/icon_broken.dart';
import '../description/description.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getCategories()
        ..x,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var list = HomeCubit.get(context).categories;

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
              actions: [
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
                IconButton(
                  onPressed: () {
                    navigateTo(context, HomePage());
                  },
                  icon: Icon(
                    Icons.sunny,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: cubit.len > 0,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: buildHomeCover(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ConditionalBuilder(
                                  condition: cubit.len > 0,
                                  fallback: (context) => Center(
                                      child: CircularProgressIndicator()),
                                  builder: (context) => InkWell(
                                    onTap: () {
                                      // print(data.name);
                                      // print(data.categoryItems![index].title);
                                      cubit.changeindex(z: index);
                                      // print(index);
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blueGrey),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Text(
                                            cubit.categoryModel!.data![index]
                                                .name!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                height: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 5,
                                  ),
                              itemCount: cubit.len),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                        // child: Text(
                        //   'Top trips',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 15),
                        // ),
                      ),
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          shrinkWrap: true,
                          itemCount: cubit.categoryModel!.data![cubit.x]
                              .categoryItems!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildGrid(
                                cubit.categoryModel!.data![cubit.x]
                                    .categoryItems![index],
                                context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildGrid(CategoryItems categoryItems, context) => Container(
        child: InkWell(
          onTap: () {
            navigateTo(
                context,
                DescriptionScreen(
                  decs: categoryItems.description!,
                  image: categoryItems.cover!,
                  location: categoryItems.address!,
                  title: categoryItems.title!,
                  url: categoryItems.map!,
                ));
          },
          child: Card(
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(categoryItems.cover!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.location,
                          color: Colors.amber,
                        ),
                        Container(
                          child: Text(
                            categoryItems.address!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                height: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, left: 10, top: 20),
                  child: Text(
                    categoryItems.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      );

  Widget buildHomeCover(context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYiYVkwDQbyvaySpMAXeu_3zjasa244VUAlQ&usqp=CAU"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
