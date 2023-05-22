// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_unnecessary_containers
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/modules/login/cubit/cubit.dart';
import 'package:flutter_application_1/modules/login/cubit/states.dart';
import 'package:flutter_application_1/modules/profile/profilePerson.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constantes.dart';
import '../../shared/style/icon_broken.dart';
import '../comments/comments.dart';
import 'create_post.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()
        ..getProfile()
        ..getPosts(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = LoginCubit.get(context);
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
                condition:
                    cubit.postModel.isNotEmpty && cubit.profileModel != null,
                fallback: (BuildContext context) => Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        buildCreatePost(context),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildPostItem(
                            context,
                            LoginCubit.get(context).postModel,
                            index,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: LoginCubit.get(context).postModel.length,
                        ),
                      ],
                    ),
                  );
                },
              ));
        },
      ),
    );
  }

  Widget buildCreatePost(context) => Card(
        elevation: 15,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(LoginCubit.get(context)
                      .profileModel!
                      .data!
                      .profilepicture
                      .toString())),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      navigateTo(context, CreatePost());
                    },
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 0.1,
                                  color: Color.fromARGB(255, 94, 93, 93))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('What is on your mind ...',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
  Widget buildPostItem(
    context,
    List<PostModel> model,
    index,
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
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        ProfilePersonScreen(
                          postId: model[index].userId!,
                        ));
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(model[index].profilePic.toString()),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model[index].name.toString(),
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
                if (userId == model[index].userId)
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
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(
                                                        // color: defaultColor2,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: deffaultTextButton(
                                                          onPressed: () {
                                                            LoginCubit.get(
                                                                    context)
                                                                .deletePost(
                                                                    postId: model[
                                                                            index]
                                                                        .postId
                                                                        .toString());
                                                          },
                                                          text: 'delete'),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: deffaultTextButton(
                                                          onPressed: () {
                                                            navigateTo(context,
                                                                PostScreen());
                                                          },
                                                          text: 'Cancel'),
                                                    ),
                                                  )
                                                ],
                                              ),
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
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ]),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   child: myDivider(),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ReadMoreText(
                  model[index].description.toString() == "null"
                      ? " "
                      : model[index].description.toString(),
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, height: 1.1),
                ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // if (model[index].postId == model[index].postId) {
                                LoginCubit.get(context)
                                    .li1(model[index].postId.toString());
                                // }
                                // LoginCubit.get(context).li1(
                                //   model[index].postId.toString(),
                                //   index,
                                // );
                                // LoginCubit.get(context).li2(
                                //     model[index].likes![index].likeId.toString(),
                                //     model[index].postId.toString(),
                                //     index);
                              },
                              icon: Icon(
                                IconBroken.heart,
                                color: Colors.red,
                                weight: 2,
                              ),
                              // (LoginCubit.get(context).iconLike

                              //     // Icons.abc
                              //     ),
                            ),
                            // const SizedBox(
                            //   width: 5,
                            // ),

                            SizedBox(
                              width: 3,
                            ),
                            Text('Like'),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: const [
                          Spacer(),
                          Icon(
                            IconBroken.chat,
                            color: Colors.amber,
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     IconBroken.chat,
                          //     size: 20,
                          //     color: Colors.amber,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          // Text(model[index].comments!.length.toString()),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Comment'),
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
                        width: 150,
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
              ),
            ],
          ),
        ),
      );
  Widget buildCommentItem(
    context,
    List<PostModel> model,
    index,
  ) =>
      Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(LoginCubit.get(context)
                .profileModel!
                .data!
                .profilepicture
                .toString()),
          ),
          const SizedBox(
            width: 5,
          ),
          TextButton(
            onPressed: () {
              navigateTo(
                  context,
                  CommentScreen(
                    postId: model[index].postId!,
                    index: model[index].comments!.length,
                    commentText: model[index].comments!,
                  ));
            },
            child: Text('write a comment...',
                style: Theme.of(context).textTheme.bodySmall),
          ),
          const Spacer(),
        ],
      );
}
