import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/app_theme/app_theme.dart';
import 'package:investment_app/widgets/widgets.dart';
import '../../Login/Login_controller.dart';
import '../widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
    LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put<LoginController>(LoginController());
    return Scaffold(
      body: ListView(
          children: [
            FullHeader(HeaderText: "Login"),
            SizedBox(height:MediaQuery.of(context).size.height*0.2,),
            GetBuilder<LoginController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Email',
                        controller: controller.emailController,
                        icon: Icons.email,
                      ),
                      Obx(() => CustomTextField(
                        label: 'Password',
                        controller: controller.passwordController,
                        icon: Icons.lock,
                        obscure: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[700],
                            size: 22,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      )),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.Login();
                            //=> controller.login(context)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Login',
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                          child: Text(
                              "If you don't have an account?",
                            style:TextStyle(
                              color: Colors.grey
                            ),
                          )
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: ()=> Get.toNamed('/registerScreen'),
                        child: Center(
                          child: Text(
                              "Register",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),

    );
  }
}
