// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, unused_element

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constantes.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/colors.dart';
import '../forget_password/forget_password.dart';
import '../register/register_screen.dart';
import '../zoom_drawer/zoom_drawer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
          
            print('toooooooooooooken');
            print(state.model.data!.token);
            print(state.model.data);
            CacheHelper.saveData(
                key: 'image', value: state.model.data!.profilePic);
            CacheHelper.saveData(key: 'token', value: state.model.data!.token);
            CacheHelper.saveData(
                key: 'name', value: state.model.data!.firstName);
            CacheHelper.saveData(key: 'email', value: state.model.data!.email);
            CacheHelper.saveData(
                key: 'userId', value: state.model.data!.userId);
           
            print('name:$token');
              
            navigateAndFinish(context, ZoomDrawe());
            showToast(
                text: 'Logged in successfully ', state: ToastState.sUCCESS);
          }
          if (state is LoginErrorState) {
            print('77');

            if (state.error.errorData!.username.toString() != null) {
              showToast(
                  text: state.error.errorData!.username.toString(),
                  state: ToastState.eRORR);
            } else if (state.error.errorData!.password.toString() != null) {
              showToast(
                  text: 'Invalid Username or Password',
                  state: ToastState.eRORR);
              print(
                state.error.errorData!.password,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Stack(children: [
                  buildBigCircle(),
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
                              height: 60,
                            ),
                            Text(
                              'Email',
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
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
                                  return 'please enter your Email Address ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Password',
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
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
                                cubit.passwordVisibility();
                              },
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'password is not short';
                                }
                                return null;
                              },
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // navigateAndFinish(context, safariScreen());
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                deffaultTextButton(
                                    text: 'Forget Password?',
                                    onPressed: () {
                                      navigateTo(
                                          context, ForgetPasswordScreen());
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 110,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLodingState,
                              builder: (context) => deffaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'login'),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                            Center(
                              child: Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: HexColor('285430')),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: deffaultTextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSmallCircle() => Positioned(
        bottom: 0,
        right: -10,
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: HexColor('a4be7b'),
            borderRadius: BorderRadiusDirectional.circular(100),
          ),
        ),
      );
  Widget buildBigCircle() => Positioned(
        top: 150,
        left: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              color: HexColor('a4be7b'),
              borderRadius: BorderRadiusDirectional.circular(150)),
        ),
      );
  Widget buildLogLabel() {
    return Center(
      child: Text(
        'Login',
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
              color: defaultColor2, fontWeight: FontWeight.w900, fontSize: 50),
        ),
      ),
    );
  }
}
