// ignore_for_file: unused_local_variable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/modules/login/cubit/states.dart';

import '../../shared/components/components.dart';
import 'cubut/cubit.dart';
import 'cubut/states.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPassCubit(),
      child: BlocConsumer<ForgetPassCubit, ForgetPassState>(
        listener: (context, state) {
          if (state is ForgetPassSuccessState) {
            print('toooooooooooooken');

            showToast(text: 'Check your email ', state: ToastState.sUCCESS);
          }
          if (state is ForgetPassErrorState) {
            print(
              state.error.toString(),
            );
            showToast(text: state.error.toString(), state: ToastState.eRORR);
          }
        },
        builder: (context, state) {
          var cubit = ForgetPassCubit.get(context);
          return Scaffold(
            appBar: deffaultAppBar(context: context),
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buoldImage(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Forget yor password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                'Enter your email address to \n retrieve your password',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Email',
                              // style: GoogleFonts.josefinSans(
                              //   textStyle: const TextStyle(
                              //     color: Color(0xffc5d2e1),
                              //     fontWeight: FontWeight.w400,
                              //     fontSize: 20,
                              //   ),
                              // ),
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
                              height: 50,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLodingState,
                              builder: (context) => deffaultButton(
                                  radius: 50,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.forgetPass(
                                          email: emailController.text);
                                    }
                                  },
                                  text: 'Reset Password'),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buoldImage() => Image.asset(
        'assets/images/ffff.jpg',
        width: double.infinity,
        height: 270,
        fit: BoxFit.fill,
      );
}
