// ignore_for_file: file_names, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/components/components.dart';
import 'cubet/cubet.dart';
import 'cubet/status.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePassCubit(),
      child: BlocConsumer<ChangePassCubit, ChangePassState>(
        listener: (context, state) {
          if (state is ChangePassSuccessState) {
            showToast(
                text: state.passModel.message!, state: ToastState.sUCCESS);
          }
          if (state is ChangePassErrorState) {
            showToast(
                text:
                    "Confirm NewPassword and New Password do not match or The password is incorrect",
                state: ToastState.eRORR);
          }
        },
        builder: (context, state) {
          var cubit = ChangePassCubit.get(context);
          return Scaffold(
            appBar: deffaultAppBar(context: context),
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    buildBigCircle(),
                    buildSmallCircle(),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state is ChangePassLodingState)
                                  LinearProgressIndicator(
                                    color: defaultColor2,
                                  ),
                                Center(
                                  child: Text(
                                    '  Change your password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'current Password',
                                  // style: GoogleFonts.josefinSans(
                                  //   textStyle: const TextStyle(
                                  //     color: Color(0xffc5d2e1),
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
                                ),
                                deffaultFormField(
                                  controller: currentPasswordController,
                                  prefix: Icons.lock_outline,
                                  isPassword: true,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    // RegExp regExp = RegExp(
                                    //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                                    // );
                                    // if (!regExp.hasMatch(value)) {
                                    //   return 'Please enter a password with at least 8 characters, \n containing at least one letter and one number';
                                    // }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'new Password',
                                  // style: GoogleFonts.josefinSans(
                                  //   textStyle: const TextStyle(
                                  //     color: Color(0xffc5d2e1),
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
                                ),
                                deffaultFormField(
                                  controller: newPasswordController,
                                  prefix: Icons.lock_outline,
                                  suffix: cubit.iconData,
                                  isPassword: cubit.isPassword,
                                  suffixPressed: () {
                                    cubit.passwordVisibility();
                                  },
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    // RegExp regExp = RegExp(
                                    //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                                    // );
                                    // if (!regExp.hasMatch(value)) {
                                    //   return 'Please enter a password with at least 8 characters, \n containing at least one letter and one number';
                                    // }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'confirm New Password',
                                  // style: GoogleFonts.josefinSans(
                                  //   textStyle: const TextStyle(
                                  //     color: Color(0xffc5d2e1),
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
                                ),
                                deffaultFormField(
                                  controller: confirmNewPasswordController,
                                  prefix: Icons.lock_outline,
                                  isPassword: true,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return ' confirmNewPasswordController';
                                    } else if (value !=
                                        confirmNewPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                ConditionalBuilder(
                                  condition: state is! ChangePassLodingState,
                                  builder: (context) => deffaultButton(
                                      radius: 50,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.ChangePass(
                                              currentPassword:
                                                  currentPasswordController
                                                      .text,
                                              newPassword:
                                                  newPasswordController.text,
                                              confirmNewPassword:
                                                  confirmNewPasswordController
                                                      .text);
                                        }
                                      },
                                      text: 'change your password'),
                                  fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSmallCircle() => Positioned(
        bottom: 10,
        right: -10,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: HexColor('f29e7d'),
            borderRadius: BorderRadiusDirectional.circular(100),
          ),
        ),
      );
  Widget buildBigCircle() => Positioned(
        top: 120,
        left: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              color: const Color(0x304599ff),
              borderRadius: BorderRadiusDirectional.circular(150)),
        ),
      );
  Widget buildLogLabel() {
    return const Center(
      child: Text(
        'Login',
        // style: GoogleFonts.josefinSans(
        //   textStyle: const TextStyle(
        //       color: Color(0xff164276),
        //       fontWeight: FontWeight.w900,
        //       fontSize: 34),
        // ),
      ),
    );
  }
}
