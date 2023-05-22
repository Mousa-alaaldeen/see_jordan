// ignore_for_file: unused_local_variable, dead_code, avoid_print

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/register/cubit/cubi.dart';
import 'package:flutter_application_1/modules/register/cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/components/components.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/style/colors.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firatNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  // ignore: non_constant_identifier_names
  var ConfirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterLodingState) {
            showToast(text: 'Check your email', state: ToastState.sUCCESS);
          }
          if (state is RegisterErrorState) {
            print(
              state.error.toString(),
            );
            showToast(text: state.error.toString(), state: ToastState.eRORR);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Stack(children: [
                  buildSmallCircle(),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            buildLogLabel(),
                            const SizedBox(
                              height: 40,
                            ),
                            Column(
                              children: [
                                if (state is RegisterSuccessState)
                                  const LinearProgressIndicator(),
                                Text(
                                  'First name',
                                  style: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            deffaultFormField(
                              controller: firatNameController,
                              prefix: Icons.person,
                              suffixPressed: () {},
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                RegExp regExp = RegExp(
                                  r'^[a-zA-Z]{2,}$',
                                );
                                if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid first name with at least 2 letters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'last name',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            deffaultFormField(
                              controller: lastNameController,
                              prefix: Icons.person,
                              suffixPressed: () {},
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                RegExp regExp = RegExp(
                                  r'^[a-zA-Z]{2,}$',
                                );
                                if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid last name with at least 2 letters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Email',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            deffaultFormField(
                              controller: emailController,
                              prefix: Icons.email,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                RegExp emailRegExp =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegExp.hasMatch(value.toString())) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Password',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            deffaultFormField(
                              controller: passwordController,
                              prefix: Icons.lock_outline,
                              suffix: cubit.iconData,
                              isPassword: cubit.isPassword,
                              suffixPressed: () {
                                cubit.PasswordVisibility();
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
                              height: 20,
                            ),
                            Text(
                              'Confirm Password',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            deffaultFormField(
                              controller: ConfirmPasswordController,
                              prefix: Icons.lock_outline,
                              isPassword: true,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                } else if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'phone',
                              style: GoogleFonts.josefinSans(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            deffaultFormField(
                              controller: phoneController,
                              prefix: Icons.phone_android,
                              suffixPressed: () {},
                              type: TextInputType.text,
                              validate: (String? value) {
                                return null;

                                // if (value!.isEmpty) {
                                //   return 'Please enter your phone number';
                                // }
                                // RegExp regExp = RegExp(r'^\+962[789]\d{7}$');
                                // if (!regExp.hasMatch(value)) {
                                //   return 'Invalid Jordanian phone number';
                                // }
                                // return null;
                              },
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                            deffaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          ConfirmPasswordController.text,
                                      firatName: firatNameController.text,
                                      lastName: lastNameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                  print('eee');
                                },
                                text: 'register'),
                            const SizedBox(
                              height: 90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSmallCircle() => Positioned(
        top: 140,
        left: -275,
        child: Container(
          width: 550,
          height: 550,
          decoration: BoxDecoration(
              color: HexColor('a4be7b'),
              borderRadius: BorderRadiusDirectional.circular(250)),
        ),
      );
  Widget buildBigCircle() => Positioned(
        bottom: 10,
        right: 0,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: HexColor('a4be7b'),
            borderRadius: BorderRadiusDirectional.circular(125),
          ),
        ),
      );
  Widget buildLogLabel() {
    return Center(
      child: Text(
        'Register',
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
              color: defaultColor2, fontWeight: FontWeight.w900, fontSize: 34),
        ),
      ),
    );
  }
}
