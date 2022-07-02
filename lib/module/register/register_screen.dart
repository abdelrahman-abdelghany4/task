import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/module/login/login_screen.dart';
import 'package:task/module/register/cubit/cubit.dart';
import 'package:task/shared/components/applocal.dart';
import 'package:task/shared/components/component.dart';

import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();
  var cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            navegateAndReplacement(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: design(
                child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    children: [
                      defaultFormField(
                        label: '${getLang(context, 'Full name')}',
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your Full Name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        label: '${getLang(context, 'Email')}',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        label: '${getLang(context, 'Phone')}',
                        controller: phoneController,
                        keyboardType: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your Phone Number';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty && value.length < 6) {
                            return 'password is too short';
                          }
                        },
                        label: '${getLang(context, 'Password')}',
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: cPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is not match';
                          }
                        },
                        label: '${getLang(context, 'Confirm password')}',
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 106,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          defaultButton(
                            text: '${getLang(context, 'Register')}',
                            function: () {
                              RegisterCubit.get(context).userRegister(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  password: cPasswordController.text,
                                  phone: phoneController.text);
                            },
                            background: HexColor("#005DA3"),
                          ),
                          defaultButton(
                            text: '${getLang(context, 'Login')}',
                            function: () {
                              navegateAndReplacement(context, LoginScreen());
                            },
                            background: HexColor("#005DA3"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
