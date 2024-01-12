import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:we_healthy/screen/welcome_page.dart';
import 'package:we_healthy/utils/fire_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Column(
          children: <Widget>[
            Image.asset(
              "assets/logo/logo.png",
            )
          ],
        ),
        backgroundColor: Color(0xFF0086C4),
        nextScreen: WelcomeScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        duration: 1000,
      ),
    );
  }
}
