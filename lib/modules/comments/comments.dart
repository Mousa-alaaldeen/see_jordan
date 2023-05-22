// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, must_be_immutable, avoid_unnecessary_containers, prefer_if_null_operators
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/modules/login/cubit/cubit.dart';
import 'package:flutter_application_1/modules/login/cubit/states.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constantes.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen(
      {super.key,
      required this.index,
      required this.commentText,
      required this.postId});
  final int index;
  final String postId;

  final List<Comments> commentText;

  String uid = userId!;

  @override
  Widget build(BuildContext context) {
    var commentTextControl = TextEditingController();
    commentTextControl.text = '';
    var commentImage = TextEditingController();
    commentImage.text = '';
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getPosts(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, Object? state) {
          if (state is DeleteCommentSuccessState) {
            showToast(
                text: 'Logged in successfully ', state: ToastState.wORNING);
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Comments',
                style: GoogleFonts.abyssinicaSil(
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: ListView.separated(
                    // physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        commentText[index]
                                            .commenterPic
                                            .toString()),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        commentText[index].commenterName!,
                                        style: GoogleFonts.abyssinicaSil(
                                            fontWeight: FontWeight.bold,
                                            height: 1.1),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          commentText[index]
                                              .commentCreated!
                                              .substring(0, 10)
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                  Spacer(),
                                  if (userId == commentText[index].commenterId)
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
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size: 30,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'Delete this comment?',
                                                                          style:
                                                                              GoogleFonts.josefinSans(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              // color: defaultColor2,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Center(
                                                                  child: deffaultTextButton(
                                                                      onPressed: () {
                                                                        LoginCubit.get(context).deleteComment(
                                                                            commentId:
                                                                                commentText[index].commentId.toString());
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
                                ],
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(vertical: 10),
                              //   child: myDivider(),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  commentText[index]
                                      .descriptionComment
                                      .toString(),
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500, height: 1.1),
                                ),
                              ),
                              if (commentText[index].image != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Image.network(
                                    commentText[index].image.toString(),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: index,
                  ),
                ),
                // Spacer(),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: commentTextControl,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: defaultColor2,
                    // style: TextStyle(color: Colors.deepOrange),
                    validator: (value) {
                      if (value!.isEmpty) return null;
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: TextStyle(color: Colors.grey[200]),
                      fillColor: Colors.grey[200],
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                LoginCubit.get(context).createComment(
                                  userId: uid,
                                  postId: postId,
                                  comment: commentTextControl.text,
                                );
                                commentTextControl.clear();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
