// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/setting/cubit/cubit.dart';
import 'package:flutter_application_1/modules/setting/cubit/states.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:flutter_application_1/shared/style/icon_broken.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var phone = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  //password
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  var formKeyPassword = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SettingCubit()..mod,
        child: BlocConsumer<SettingCubit, SettingStates>(
          listener: (context, state) {
            if (state is ChangePhoneSuccessState) {
              showToast(
                  text: state.PhoneModel.message!, state: ToastState.sUCCESS);
            }
            if (state is ChangePhoneErrorState) {
              showToast(text: "Try again", state: ToastState.eRORR);
            }
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
            var cubit = SettingCubit.get(context);

            return Scaffold(
              appBar: deffaultAppBar(
                context: context,
                title: Text(
                  'Setting',
                  style: GoogleFonts.abyssinicaSil(
                      fontWeight: FontWeight.bold, height: 1.1, fontSize: 20),
                ),
              ),
              body: Column(
                children: [
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                child: AlertDialog(
                                  content: Form(
                                    key: formKeyPassword,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (state is ChangePassLodingState)
                                            LinearProgressIndicator(
                                              color: defaultColor2,
                                            ),
                                          Text(
                                            'Current Password',
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                color: defaultColor2,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          deffaultFormField(
                                            controller:
                                                currentPasswordController,
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
                                            height: 25,
                                          ),
                                          Text(
                                            'New Password',
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                color: defaultColor2,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          deffaultFormField(
                                            controller: newPasswordController,
                                            prefix: Icons.lock_outline,
                                            // suffix: cubit.iconDatachangepassword,
                                            isPassword: true,
                                            // suffixPressed: () {
                                            //   cubit
                                            //       .passwordVisibilitychangepassword();
                                            // },
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
                                            height: 25,
                                          ),
                                          Center(
                                            child: Text(
                                              'Confirm New Password',
                                              style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                  color: defaultColor2,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          deffaultFormField(
                                            controller:
                                                confirmNewPasswordController,
                                            prefix: Icons.lock_outline,
                                            isPassword: true,
                                            type: TextInputType.text,
                                            validate: (String? value) {
                                              if (value!.isEmpty) {
                                                return ' confirmNewPasswordController';
                                              } else if (value !=
                                                  confirmNewPasswordController
                                                      .text) {
                                                return 'Passwords do not match';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          ConditionalBuilder(
                                            condition:
                                                state is! ChangePassLodingState,
                                            builder: (context) =>
                                                deffaultTextButton(
                                                    text:
                                                        'Change your password',
                                                    onPressed: () {
                                                      if (formKeyPassword
                                                          .currentState!
                                                          .validate()) {
                                                        cubit.ChangePass(
                                                            currentPassword:
                                                                currentPasswordController
                                                                    .text,
                                                            newPassword:
                                                                newPasswordController
                                                                    .text,
                                                            confirmNewPassword:
                                                                confirmNewPasswordController
                                                                    .text);
                                                      }
                                                    }),
                                            fallback: (context) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    deffaultTextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'cancel',
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: deffaultListTitle(
                          icon: IconBroken.lock, title: 'password')),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                child: AlertDialog(
                                  content: Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (state is ChangePhoneLodingState)
                                            LinearProgressIndicator(),
                                          if (state is ChangePhoneLodingState)
                                            SizedBox(
                                              height: 10,
                                            ),
                                          Text(
                                            "Email",
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                color: defaultColor2,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          deffaultFormField(
                                            controller: email,
                                            prefix: Icons.email,
                                            type: TextInputType.emailAddress,
                                            validate: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a Email';
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
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            'Password',
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                color: defaultColor2,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          deffaultFormField(
                                            controller: passwordController,
                                            prefix: Icons.lock_outline,
                                            // suffix: cubit.iconDataPhone,
                                            isPassword: true,
                                            // suffixPressed: () {
                                            //   cubit.passwordVisibilityPhone;
                                            // },
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
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ConditionalBuilder(
                                            condition: state
                                                is! ChangePhoneLodingState,
                                            builder: (context) =>
                                                deffaultTextButton(
                                                    text: 'change your Email',
                                                    onPressed: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        cubit.ChangeEmail(
                                                          email: email.text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                        );
                                                      }
                                                    }),
                                            fallback: (context) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    deffaultTextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'cancel'),
                                  ],
                                ),
                              );
                            });
                      },
                      child: deffaultListTitle(
                          icon: IconBroken.message, title: 'Email')),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                child: AlertDialog(
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (state is ChangePhoneLodingState)
                                          LinearProgressIndicator(),
                                        if (state is ChangePhoneLodingState)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        Text(
                                          "Phone",
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(
                                              color: defaultColor2,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        deffaultFormField(
                                          controller: phone,
                                          prefix: Icons.phone,
                                          type: TextInputType.text,
                                          validate: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a phone';
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
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          'Password',
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(
                                              color: defaultColor2,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        deffaultFormField(
                                          controller: passwordController,
                                          prefix: Icons.lock_outline,
                                          // suffix: cubit.iconDataPhone,
                                          isPassword: true,
                                          // suffixPressed: () {
                                          //   cubit.passwordVisibilityPhone();
                                          // },
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
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ConditionalBuilder(
                                          condition:
                                              state is! ChangePhoneLodingState,
                                          builder: (context) =>
                                              deffaultTextButton(
                                                  text: 'change your password',
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      cubit.ChangePhone(
                                                        phone: phone.text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                      );
                                                    }
                                                  }),
                                          fallback: (context) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    deffaultTextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'cancel'),
                                  ],
                                ),
                              );
                            });
                      },
                      child: deffaultListTitle(
                          icon: IconBroken.call, title: 'Phone')),
                ],
              ),
            );
          },
        ));
  }
}
