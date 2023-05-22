// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/style/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/components/components.dart';
import 'cubet/cubet.dart';
import 'cubet/status.dart';

// ignore: must_be_immutable
class ChangePhoneScreen extends StatelessWidget {
  var phone = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ChangePhoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePhoneCubit(),
      child: BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
        listener: (context, state) {
          if (state is ChangePhoneSuccessState) {
            showToast(
                text: state.PhoneModel.message!, state: ToastState.sUCCESS);
          }
          if (state is ChangePhoneErrorState) {
            showToast(text: "Try again", state: ToastState.eRORR);
          }
        },
        builder: (context, state) {
          var cubit = ChangePhoneCubit.get(context);
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
                                if (state is ChangePhoneLodingState)
                                  LinearProgressIndicator(
                                    color: defaultColor2,
                                  ),
                                Center(
                                  child: Text(
                                    '  Change your phone',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                 Text(
                                  'phone Number',
                                  // style: GoogleFonts.josefinSans(
                                  //   textStyle: const TextStyle(
                                  //     color: Color(0xffc5d2e1),
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
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
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'Password',
                                  // style: GoogleFonts.josefinSans(
                                  //   textStyle: const TextStyle(
                                  //     color: Color(0xffc5d2e1),
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 20,
                                  //   ),
                                  // ),
                                ),
                                deffaultFormField(
                                  controller: passwordController,
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
                                ConditionalBuilder(
                                  condition: state is! ChangePhoneLodingState,
                                  builder: (context) => deffaultButton(
                                      radius: 50,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.ChangePhone(
                                            phone: phone.text,
                                            password: passwordController.text,
                                          );
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
