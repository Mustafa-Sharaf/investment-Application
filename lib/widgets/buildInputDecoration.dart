import 'package:flutter/material.dart';
import 'package:investment_app/app_theme/app_theme.dart';


InputDecoration buildInputDecoration(BuildContext context, IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    labelText: hinttext,
    prefixIcon: Icon(icons, color: AppColors.primaryColor,),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}