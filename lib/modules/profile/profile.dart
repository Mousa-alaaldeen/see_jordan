// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unused_element

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/login/cubit/cubit.dart';
import 'package:flutter_application_1/shared/components/constantes.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../models/post_model.dart';
import '../../models/profile_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/icon_broken.dart';
import '../comments/comments.dart';
import '../login/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()
        ..getProfilem()
        ..profileModel,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
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
            body: ConditionalBuilder(
              condition: LoginCubit.get(context).profileMode != null,
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            Container(
                              height: 300,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Container(
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                bottomLeft:
                                                    Radius.circular(4.0),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    LoginCubit.get(context)
                                                        .profileMode!
                                                        .data!
                                                        .coverpicture
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 72,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              LoginCubit.get(context)
                                                  .profileMode!
                                                  .data!
                                                  .profilepicture
                                                  .toString(),
                                            ),
                                            backgroundColor: Colors.white,
                                            radius: 70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        LoginCubit.get(context)
                                            .profileMode!
                                            .data!
                                            .name
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.abyssinicaSil(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            height: 0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    LoginCubit.get(context)
                                                .profileMode!
                                                .data!
                                                .bio ==
                                            null
                                        ? 'bio......'
                                        : LoginCubit.get(context)
                                            .profileMode!
                                            .data!
                                            .bio
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildPostItem(
                            context,
                            LoginCubit.get(context).profilePost,
                            index,
                            LoginCubit.get(context).postModel,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: LoginCubit.get(context).profilePost.length,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _buildCoverAndProfileImages(
  context,
  List<Post> model,
) {
  return Container(
    height: 250,
    child: Stack(alignment: Alignment.topCenter, children: [
      Container(
        height: 300,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaKjnGKk4_z818JWkv9YdTinjFmlQnWcR2cA&usqp=CAU',
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.camera,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYiYVkwDQbyvaySpMAXeu_3zjasa244VUAlQ&usqp=CAU'),
                      backgroundColor: Colors.white,
                      radius: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.camera,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]),
  );
}

Widget _buildUsernameAndBio(
  context,
) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          children: [
            Text(
              '$name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'bio......',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    ],
  );
}

Widget buildPostItem(
  context,
  List<Post> model,
  index,
  List<PostModel> postModel,
) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(10),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            Row(children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  LoginCubit.get(context)
                      .profileMode!
                      .data!
                      .profilepicture
                      .toString(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LoginCubit.get(context).profileMode!.data!.name.toString(),
                    style: GoogleFonts.abyssinicaSil(
                        fontWeight: FontWeight.bold, height: 1.1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(model[index].postCreated!.substring(0, 10).toString(),
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              child: AlertDialog(
                                content: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Delete this post?',
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(
                                                    // color: defaultColor2,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: deffaultTextButton(
                                                onPressed: () {
                                                  LoginCubit.get(context)
                                                      .deletePost(
                                                          postId: model[index]
                                                              .postId
                                                              .toString());
                                                },
                                                text: 'delete'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      IconBroken.arrowDownCircle,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                  ),
                ],
              ),
            ]),

            ReadMoreText(
              model[index].description.toString() == "null"
                  ? " "
                  : model[index].description.toString(),
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, height: 1.1),
            ),
            if (model[index].poster != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  model[index].poster.toString(),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            LoginCubit.get(context)
                                .li1(model[index].postId.toString());
                          },
                          icon: Icon(
                            IconBroken.heart,
                            color: Colors.red,
                            weight: 2,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('Like'),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      children: const [
                        Spacer(),
                        Icon(
                          IconBroken.chat,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('Comment'),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ))
                  ],
                ),
                Row(
                  children: [
                    if (model[index].likes!.isNotEmpty)
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Text(model[index].likes!.length.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Likes',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: 100,
                    ),
                    if (model[index].comments!.isNotEmpty)
                      Expanded(
                        child: Row(
                          children: [
                            Text(model[index].comments!.length.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Comments',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: myDivider(),
            ),
            buildCommentItem(
              context,
              LoginCubit.get(context).postModel,
              index,
              LoginCubit.get(context).profileMode,
            ),
          ],
        ),
      ),
    );
Widget buildCommentItem(
  context,
  List<PostModel> model,
  index,
  ProfileModel? profileMode,
) =>
    Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            LoginCubit.get(context)
                .profileMode!
                .data!
                .profilepicture
                .toString(),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        TextButton(
          onPressed: () {
            navigateTo(
                context,
                CommentScreen(
                  postId: profileMode!.data!.posts![index].postId.toString(),
                  index: profileMode.data!.posts!.length,
                  commentText: model[index].comments!,
                ));
          },
          child: Text('write a comment...',
              style: Theme.of(context).textTheme.bodySmall),
        ),
        const Spacer(),
      ],
    );
