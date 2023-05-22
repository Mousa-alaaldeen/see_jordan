// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class EditScreen extends StatelessWidget {
//   EditScreen({super.key});
//   var nameController = TextEditingController();
//   var bioController = TextEditingController();
//   var phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var usarModel = SocialCubit.get(context).model;
//         var profileImage = SocialCubit.get(context).profileImage;
//         var coverImage = SocialCubit.get(context).coverImage;
//         nameController.text = usarModel!.name!;
//         bioController.text = usarModel.bio!;
//         phoneController.text = usarModel.phone!;

//         return Scaffold(
//           appBar: deffaultAppBar(
//             context: context,
//             title: Text("'Edit Profile'"),
//             actions: [
//               deffaultTextButton(
//                   onPressed: () {
//                     SocialCubit.get(context).updateUser(
//                         name: nameController.text,
//                         phone: phoneController.text,
//                         bio: bioController.text);
//                   },
//                   text: 'Update'),
//               const SizedBox(
//                 width: 10,
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   if (state is SocialUpdateUserLodingState)
//                     const LinearProgressIndicator(
//                       minHeight: 4,
//                     ),
//                   if (state is SocialUpdateUserLodingState)
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   Container(
//                     height: 250,
//                     child: Stack(
//                       alignment: AlignmentDirectional.bottomCenter,
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional.topCenter,
//                           child: Stack(
//                             alignment: AlignmentDirectional.topEnd,
//                             children: [
//                               Container(
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(4.0),
//                                     bottomLeft: Radius.circular(4.0),
//                                   ),
//                                   image: DecorationImage(
//                                       image: coverImage == null
//                                           ? NetworkImage('${usarModel.cover}')
//                                           : FileImage(coverImage)
//                                               as ImageProvider,
//                                       fit: BoxFit.fill),
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   SocialCubit.get(context).getCoverImage();
//                                 },
//                                 icon: const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 20,
//                                   child: Icon(
//                                     IconBroken.Camera,
//                                     size: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         CircleAvatar(
//                           radius: 60,
//                           backgroundColor:
//                               Theme.of(context).scaffoldBackgroundColor,
//                           child: Stack(
//                             alignment: AlignmentDirectional.bottomEnd,
//                             children: [
//                               CircleAvatar(
//                                 radius: 55,
//                                 backgroundImage: profileImage == null
//                                     ? NetworkImage("${usarModel.image}")
//                                     : FileImage(profileImage) as ImageProvider,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   SocialCubit.get(context).getProfileImage();
//                                 },
//                                 icon: const CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 20,
//                                   child: Icon(
//                                     IconBroken.Camera,
//                                     size: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   if (SocialCubit.get(context).profileImage != null ||
//                       SocialCubit.get(context).coverImage != null)
//                     Row(
//                       children: [
//                         if (SocialCubit.get(context).profileImage != null)
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 deffaultButton(
//                                   function: () {
//                                     SocialCubit.get(context).uploadProfileImage(
//                                       name: nameController.text,
//                                       phone: phoneController.text,
//                                       bio: bioController.text,
//                                     );
//                                   },
//                                   text: 'upload profile',
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 if (state is SocialUpdateUserLodingState)
//                                   LinearProgressIndicator(),
//                               ],
//                             ),
//                           ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         if (SocialCubit.get(context).coverImage != null)
//                           Expanded(
//                               child: Column(
//                             children: [
//                               deffaultButton(
//                                   function: () {
//                                     SocialCubit.get(context).uploadCoverImage(
//                                       name: nameController.text,
//                                       phone: phoneController.text,
//                                       bio: bioController.text,
//                                     );
//                                   },
//                                   text: 'upload  cover'),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               if (state is SocialUpdateUserLodingState)
//                                 LinearProgressIndicator(),
//                             ],
//                           )),
//                       ],
//                     ),
//                   if (SocialCubit.get(context).profileImage != null ||
//                       SocialCubit.get(context).coverImage != null)
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   deffaultFormField(
//                     controller: nameController,
//                     labelText: ' Name',
//                     type: TextInputType.name,
//                     prefix: IconBroken.User,
//                     validate: (value) {
//                       if (value!.isEmpty) {
//                         return 'name must not be empty';
//                       } else
//                         return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   deffaultFormField(
//                     controller: bioController,
//                     labelText: ' Bio',
//                     type: TextInputType.text,
//                     prefix: IconBroken.Info_Circle,
//                     validate: (value) {
//                       if (value!.isEmpty) {
//                         return 'Bio must not be empty';
//                       } else
//                         return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   deffaultFormField(
//                     controller: phoneController,
//                     labelText: ' phone',
//                     type: TextInputType.phone,
//                     prefix: IconBroken.Call,
//                     validate: (value) {
//                       if (value!.isEmpty) {
//                         return 'phone must not be empty';
//                       } else
//                         return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
