import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:latihan_1/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:we_healthy/screen/welcome_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Column(
          children: <Widget>[
            Image.asset(
              '/logo/logo.png',
            )
            ],
          ),
          backgroundColor: Color(0xFF0086C4),
          nextScreen:  WelcomeScreen(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.fade,
          duration: 1000,
        ),
      ); 
    } 
}
