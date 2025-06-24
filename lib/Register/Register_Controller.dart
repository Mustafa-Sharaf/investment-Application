import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }



  Future Register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      await userCredential.user!.updateDisplayName(nameController.text.trim());
      await userCredential.user!.reload();

      Get.offAllNamed('/homeScreen');
      Get.snackbar(
        'نجاح',
        'تم تسجيل الحساب بنجاح',
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar('خطأ', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


/*
  Future Register() async {
    try {
      // تسجيل المستخدم بالبريد وكلمة المرور
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final uid = userCredential.user!.uid;

      // تحديث اسم المستخدم في Firebase Auth
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      // حفظ البيانات الإضافية في Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // الانتقال إلى الشاشة الرئيسية
      Get.offAllNamed('/homeScreen');

      // عرض رسالة نجاح
      Get.snackbar(
        'نجاح',
        'تم تسجيل الحساب بنجاح',
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // عرض رسالة الخطأ
      Get.snackbar(
        'خطأ',
        e.toString(),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error-------------$e");
    }
  }

*/


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }


}