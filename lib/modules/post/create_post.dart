// ignore_for_file: use_key_in_widget_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/login/cubit/cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../shared/style/icon_broken.dart';
import '../login/cubit/states.dart';

// ignore: must_be_immutable
class CreatePost extends StatelessWidget {
  var textController = TextEditingController();
  var imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()
        ..getProfile()
        ..profileModel,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: deffaultAppBar(
                context: context,
                title: Text(
                  'Create Post',
                  style: GoogleFonts.abyssinicaSil(
                      fontWeight: FontWeight.bold, height: 1.1, fontSize: 20),
                ),
                actions: [
                  deffaultTextButton(
                      onPressed: () {
                        LoginCubit.get(context).up(
                            LoginCubit.get(context).storieImage,
                            textController.text,
                            context);
                      },
                      text: 'Post'),
                ]),
            body: ConditionalBuilder(
              condition: LoginCubit.get(context).profileModel != null,
              fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      if (state is CreatePostLodingState)
                        const LinearProgressIndicator(),
                      if (state is CreatePostLodingState)
                        const SizedBox(
                          height: 10,
                        ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              LoginCubit.get(context)
                                  .profileModel!
                                  .data!
                                  .profilepicture
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      LoginCubit.get(context)
                                          .profileModel!
                                          .data!
                                          .name
                                          .toString(),
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.bold,
                                          height: 1.1),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                            hintText: 'what is on your mind ...',
                            border: InputBorder.none),
                      ),
                      if (LoginCubit.get(context).storieImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    LoginCubit.get(context).storieImage!,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                LoginCubit.get(context).removePostImage();
                              },
                              icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                LoginCubit.get(context).getImage();
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    IconBroken.image,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'add photo',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              )),
                        ],
                      )
                    ],
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
