// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unused_element

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

class ProfilePersonScreen extends StatelessWidget {
  const ProfilePersonScreen({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getPersonProfile(ud: postId),
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
              condition: LoginCubit.get(context).profileModel != null,
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
                                                        .profileModel!
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
                                                  .profileModel!
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
                                            .profileModel!
                                            .data!
                                            .name
                                            .toString(),
                                        style: GoogleFonts.abyssinicaSil(
                                            fontWeight: FontWeight.bold,
                                            height: 0,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    LoginCubit.get(context)
                                                .profileModel!
                                                .data!
                                                .bio ==
                                            null
                                        ? 'bio......'
                                        : LoginCubit.get(context)
                                            .profileModel!
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
                            LoginCubit.get(context).profileModel,
                            index,
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
  ProfileModel? profileModel,
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
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    profileModel!.data!.profilepicture.toString(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileModel.data!.name.toString(),
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
                                            Center(
                                              child: deffaultTextButton(
                                                  onPressed: () {
                                                    LoginCubit.get(context)
                                                        .deletePost(
                                                            postId: model[index]
                                                                .postId
                                                                .toString());
                                                  },
                                                  text: 'delet'),
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
                        Icons.list_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ReadMoreText(
                model[index].description.toString() == "null"
                    ? " "
                    : model[index].description.toString(),
                style:
                    GoogleFonts.inter(fontWeight: FontWeight.w500, height: 1.1),
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
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Likes',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconBroken.chat,
                            size: 20,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Comments',
                          style: TextStyle(fontSize: 10),
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
                              width: 16,
                            ),
                            Text(model[index].likes!.length.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            Text('Likes'),
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
                            Text('Comments'),
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
        CircleAvatar(radius: 20, backgroundImage: NetworkImage('$image')),
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
              ),
            );
          },
          child: Text('write a comment...',
              style: Theme.of(context).textTheme.bodySmall),
        ),
        const Spacer(),
      ],
    );



























// Widget buildPostIte(context) => Container(
//       height: 530,
//       child: Card(
//         elevation: 20,
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(
//                         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHIr5vlCgOluC_uFO2vLrcfyuQv0iuvu7lPQ&usqp=CAU'),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Mousa Alaaldeen',
//                         style: Theme.of(context).textTheme.copyWith().bodyLarge,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text('15-3-2023',
//                           style: Theme.of(context).textTheme.bodySmall),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: myDivider(),
//               ),
//               const Text(
//                 'وتتميز المدينة بمدخلها المحكم لكونها حفرت بين جبال شاهقة صلدة مع شق ضيق يعرف بالسيق ويبلغ طوله ألف متر وتظهر على جنباته بقايا غرف الحرس ومناطق المراقبة.',
//                 style: TextStyle(height: 2, overflow: TextOverflow.ellipsis),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Image.network(
//                     'data:image/jpeg;base64,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',
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             IconBroken.heart,
//                             size: 20,
//                             color: Colors.red,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         const Text('10'),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                       child: Row(
//                     children: [
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           IconBroken.chat,
//                           size: 20,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       const Text('10'),
//                     ],
//                   ))
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: myDivider(),
//               ),
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(
//                         'data:image/jpeg;base64,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'),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text('write a comment...',
//                       style: Theme.of(context).textTheme.bodySmall),
//                   const Spacer(),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
// Widget _buildSectionHead() {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 '100',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 'Posts',
//                 style: TextStyle(fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 '250',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 'Photos',
//                 style: TextStyle(fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 '10k',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 'Followers',
//                 style: TextStyle(fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 '300',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 'Following',
//                 style: TextStyle(fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _addAndEditRow(context) {
//     return Row(
//       children: [
//         Expanded(
//             child: OutlinedButton(
//           onPressed: () {},
//           child: Text('Add Photos'),
//         )),
//         SizedBox(
//           width: 10,
//         ),
//         OutlinedButton(
//           onPressed: () {
//             navigateTo(
//               context,
//               UpdateProfilePersonScreen(),
//             );
//           },
//           child: Icon(IconBroken.Edit),
//         ),
//       ],
//     );
//   }
// }