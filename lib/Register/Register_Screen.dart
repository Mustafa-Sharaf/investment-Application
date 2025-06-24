import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/Register/Register_Controller.dart';

import '../app_theme/app_theme.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
          builder:(controller){
            return ListView(
              children: [
                FullHeader(HeaderText: "Register"),
                SizedBox(height:MediaQuery.of(context).size.height*0.15,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Name',
                        controller: controller.nameController,
                        icon: Icons.person,
                      ),
                      CustomTextField(
                        label: 'Email',
                        controller: controller.emailController,
                        icon: Icons.email,
                      ),
                      CustomTextField(
                        label: 'Password',
                        controller: controller.passwordController,
                        icon: Icons.lock,
                        obscure: controller.obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      CustomTextField(
                        label: 'Confirm_Password',
                        controller: controller.confirmPasswordController,
                        icon: Icons.lock,
                        obscure: controller.obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                             controller.Register();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Register',
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            );

          }
      )

    );
  }
}
