import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Home_Screen/Home_Screen.dart';
import 'Login/Login_screen.dart';
import 'Onboarding/onboarding_screen.dart';
import 'Register/Register_Screen.dart';
import 'SelectMoney/CurrencyController.dart';
import 'ViewOperations/ProcessController.dart';
import 'Viewlog/LogController.dart';
import 'app_theme/app_theme.dart';
import 'auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ProcessController());
  Get.put(LogController());
  Get.put(CurrencyController());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute:'/auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionColor: Colors.green.withOpacity(0.4),
          selectionHandleColor: Colors.green,
        ),),
      getPages: [
        GetPage(name: '/auth', page: ()=>Auth()),
        GetPage(name: '/Onboarding', page: ()=>OnboardingScreen()),
        GetPage(name: '/loginScreen', page: ()=>LoginScreen()),
        GetPage(name: '/registerScreen', page: ()=>RegisterScreen()),
        GetPage(name: '/homeScreen', page: ()=>HomeScreen()),
      ],
    );
  }
}
