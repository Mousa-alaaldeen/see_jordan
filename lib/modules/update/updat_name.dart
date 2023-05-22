// // ignore_for_file: unused_local_variable, avoid_print

// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:cubit_form/cubit_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/layout/safari_app/cubit/cubit.dart';
// import 'package:flutter_application_1/layout/safari_app/cubit/statrs.dart';

// import 'package:flutter_application_1/modules/login/cubit/states.dart';
// import 'package:flutter_application_1/shared/style/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../shared/components/components.dart';

// // ignore: must_be_immutable
// class UpdatName extends StatelessWidget {
//   var firstNameController = TextEditingController();
//   var lastNameController = TextEditingController();
//   var formKey = GlobalKey<FormState>();

//   UpdatName({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => SafariCubit(),
//       child: BlocConsumer<SafariCubit, SafariState>(
//         listener: (context, state) {
//           if (state is SafariSuccessState) {
//             print('toooooooooooooken');

//             showToast(
//                 text: 'Logged in successfully ', state: ToastState.sUCCESS);
//           }
//           if (state is SafariErrorState) {
//             print(
//               state.error.toString(),
//             );
//             showToast(text: state.error.toString(), state: ToastState.eRORR);
//           }
//         },
//         builder: (context, state) {
//           var cubit = SafariCubit.get(context);
//           return Scaffold(
//             appBar: deffaultAppBar(context: context),
//             body: SingleChildScrollView(
//               child: Center(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const SizedBox(
//                               height: 50,
//                             ),
//                             Text(
//                               'firstName',
//                               style: GoogleFonts.josefinSans(
//                                 textStyle: TextStyle(
//                                   color: defaultColor2,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             deffaultFormField(
//                               controller: firstNameController,
//                               type: TextInputType.text,
//                               validate: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'please enter your Email Address ';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'last Name',
//                               style: GoogleFonts.josefinSans(
//                                 textStyle: TextStyle(
//                                   color: defaultColor2,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             deffaultFormField(
//                               controller: lastNameController,
//                               type: TextInputType.text,
//                               validate: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return 'please enter your Email Address ';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 50,
//                             ),
//                             ConditionalBuilder(
//                               condition: state is! LoginLodingState,
//                               builder: (context) => deffaultButton(
//                                   radius: 50,
//                                   function: () {
//                                     if (formKey.currentState!.validate()) {
//                                       //cubit.Safari(email: firstNameController.text);
//                                     }
//                                   },
//                                   text: 'Reset Password'),
//                               fallback: (context) => const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buoldImage() => Image.asset(
//         'assets/images/ffff.jpg',
//         width: double.infinity,
//         height: 270,
//         fit: BoxFit.fill,
//       );
// }
