import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

/*  Future Login()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    );
  }*/

  Future Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAllNamed('/homeScreen');
      Get.snackbar(
        'نجاح',
        'تم تسجيل الدخول بنجاح',
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }



  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

//investment_app