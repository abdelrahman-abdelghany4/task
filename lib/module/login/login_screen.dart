import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/module/account_info/account_ifo_screen.dart';
import 'package:task/module/login/cubit/cubit.dart';
import 'package:task/module/login/cubit/states.dart';
import 'package:task/module/register/register_screen.dart';
import 'package:task/shared/components/applocal.dart';
import 'package:task/shared/components/component.dart';
import 'package:task/shared/cubit/cubit.dart';
import 'package:task/shared/remote/colors/colors.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          navegateAndReplacement(context, AccountInfo());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              design(
                  child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 167),
                    child: Column(
                      children: [
                        defaultFormField(
                          label: '${getLang(context, "Email")}',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        defaultFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: '${getLang(context, "Password")}',
                          prefix: Icons.lock_outline,
                          suffix: LoginCubit.get(context).suffix,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 175,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            defaultButton(
                              text: '${getLang(context, "Login")}',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              background: HexColor("#005DA3"),
                            ),
                            defaultButton(
                              text: '${getLang(context, "Register")}',
                              function: () {
                                navegateAndReplacement(
                                    context, RegisterScreen());
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
              Positioned(
                top: 47,
                right: 21,
                child: defaultButton(
                  function: () {
                    AppCubit.get(context).changeAppLang();
                  },
                  text: '${getLang(context, 'lang')}',
                  height: 31,
                  background: Colors.white,
                  textColors: defaultColor,
                  fontSize: 15,
                  width: 84,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
