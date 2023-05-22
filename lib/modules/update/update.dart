// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile_model.dart';
import 'package:flutter_application_1/modules/login/cubit/states.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/components.dart';
import '../login/cubit/cubit.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key, required this.name});
  final String name;
  TextEditingController bioController = TextEditingController();
  var lastNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var bioFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()
        ..getProfile()
        ..profileModel
        ..loginModel,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          // if (state is BioSuccessState) {
          //   showToast(text: state.model.message!, state: ToastState.sUCCESS);
          // }
          // if (state is UpdateNameLodingState) {
          //   showToast(text: state.model.message!, state: ToastState.sUCCESS);
          //   firstNameController.text = state.model.data!.firstname!;
          // }
          if (state is LoginSuccessState) {
            // firstNameController.text = state.model.data!.firstName;
            // lastNameController.text = state.model.data!.firstName;
          }
        },
        builder: (context, state) {
          print(name);

          var cubit = LoginCubit.get(context);

          var model = LoginCubit.get(context).profileModel;
          // firstNameController.text = cubit.profileModel!.data!.name.toString();
          // bioController.text = model!.data!.name!;
          return Scaffold(
            appBar: deffaultAppBar(
              context: context,
              title: Text(
                'Update profile',
                style: GoogleFonts.abyssinicaSil(
                    fontWeight: FontWeight.bold, height: 1.1, fontSize: 20),
              ),
            ),
            body: ConditionalBuilder(
              condition: LoginCubit.get(context).profileModel != null &&
                  cubit.profileModel!.data!.name != null 
              ,
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) {
                String nam = model!.data!.name.toString();
                List n = nam.split(' ');
                var m = n[0];
                var x = n[1];
              bioController.text =LoginCubit.get(context).bioo;
                firstNameController.text = m.toString();
                lastNameController.text = x.toString();
                var profileImge = cubit.profilImage;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is UpdateNameLodingState)
                          const LinearProgressIndicator(),
                        if (state is UpdateNameLodingState)
                          const SizedBox(
                            height: 10,
                          ),
                        _buildCoverAndProfileImages(
                          context,
                          LoginCubit.get(context).profileModel!,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Bio',
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.grey),
                          ),
                        ),
                        deffaultFormField(
                          controller: bioController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'First Name',
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        deffaultFormField(
                          controller: firstNameController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Last Name',
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        deffaultFormField(
                          controller: lastNameController,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        deffaultButton(
                            function: () {
                              cubit.updateBio(bio: bioController.text);
                              cubit.updateName(
                                  firstname: firstNameController.text,
                                  lastname: lastNameController.text);
                              cubit.updateProfileImage(cubit.profilImage);
                              LoginCubit.get(context).updateProfileImage(
                                LoginCubit.get(context).profilImage,
                              );
                              LoginCubit.get(context).updateCoverImage(
                                LoginCubit.get(context).coverImage,
                              );
                            },
                            text: 'Update'),
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

Widget _buildCoverAndProfileImages(context, ProfileModel? model) {
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
                            model!.data!.coverpicture.toString(),
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      LoginCubit.get(context).getCoverImage();
                    },
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.camera,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 72,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        model.data!.profilepicture.toString(),
                      ),
                      backgroundColor: Colors.white,
                      radius: 70,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      LoginCubit.get(context).getprofilImage();
                    },
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.camera,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]),
  );
}

// Widget _buildUsernameAndBio(context) {
//   return
// }

//   Widget _buildSectionHead() {
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
//               UpdateUpdateScreen(),
//             );
//           },
//           child: Icon(IconBroken.Edit),
//         ),
//       ],
//     );
//   }
// }
