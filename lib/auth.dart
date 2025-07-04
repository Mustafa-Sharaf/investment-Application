import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/Home_Screen/Home_Screen.dart';


import 'Onboarding/onboarding_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (
              (context,snapshot){
                if(snapshot.hasData){
                  return HomeScreen();
                }else{
                  return OnboardingScreen();
                }
              }
          )

      ),
    );
  }
}
