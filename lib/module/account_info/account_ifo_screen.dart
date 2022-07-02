import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/model/user_model.dart';
import 'package:task/module/login/cubit/cubit.dart';
import 'package:task/module/login/cubit/states.dart';
import 'package:task/shared/components/applocal.dart';
import 'package:task/shared/components/component.dart';
import 'package:task/shared/remote/colors/colors.dart';


class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 67,
                  color: HexColor("#005DA3"),
                  child: const Center(
                    child: Text(
                      "User Data",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                ConditionalBuilder(
                    condition: LoginCubit.get(context).loginModel != null,
                    builder: (context) =>
                        userInfo(LoginCubit.get(context).loginModel!,context),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator())),
                Center(
                  child: defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: '${getLang(context, 'Logout')}',
                      background: HexColor('#AD002F'),
                      fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget userInfo(UserModel model,context) => Padding(
        padding: const EdgeInsetsDirectional.only(top: 211.0, start: 69),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${getLang(context, 'Name')} :',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
                Text(
                  ' ${model.account![0].name}',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '${getLang(context, 'Email')} :',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
                Text(
                  ' ${model.account![0].email}',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '${getLang(context, 'Phone')} :',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
                Text(
                  ' ${model.account![0].phone}',
                  style: TextStyle(fontSize: 25, color: defaultColor),
                ),
              ],
            ),
            const SizedBox(
              height: 360,
            ),
          ],
        ),
      );
}
