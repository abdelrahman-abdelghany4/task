import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task/module/login/login_screen.dart';
import 'package:task/shared/remote/cash_helper.dart';
import 'package:task/shared/remote/colors/colors.dart';

void navegateAndReplacement(context, Widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Widget,
        ), (route) {
      return false;
    });

void navegateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void signOut(context) => CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navegateAndReplacement(context, LoginScreen());
      }
    });

Widget design({
  required Widget child,
}) =>
    Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: defaultColor,
        ),
        const Positioned(
          left: 123,
          right: 122,
          top: 13,
          child: Image(
              image: AssetImage(
            'assets/images/logo.png',
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 270),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                )),
            child: child,
          ),
        ),
      ],
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      width: 350,
      decoration: BoxDecoration(
          color: HexColor("#ECECEC"), borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        cursorColor: defaultColor,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 17),
          // prefixIcon: Icon(
          //   prefix,
          // ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

Widget defaultButton({
  double? width = 152,
  double? height = 61,
  Color? background,
  bool? isUpperCase = true,
  required VoidCallback? function,
  required String text,
  Color? textColors = Colors.white,
  double? fontSize = 20,
}) =>
    Container(
      width: width,
      height: height,
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: background,
        //HexColor("F23B3F"),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Add This
        child: MaterialButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(color: textColors, fontSize: fontSize),
          ),
        ),
      ),
    );
