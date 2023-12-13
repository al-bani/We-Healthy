import 'package:flutter/material.dart';
import 'package:we_healthy/screen/detail_bmi.dart';
import 'package:we_healthy/screen/home_screen.dart';
import 'package:we_healthy/screen/profile_page.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_hari.dart';
import 'package:we_healthy/screen/splash_screen.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:we_healthy/screen/user_auth/pending_auth.dart';
import 'package:we_healthy/screen/user_auth/register_page.dart';
import 'package:we_healthy/screen/welcome_page.dart';
import 'firebase_options.dart';
import 'package:we_healthy/screen/rekomendasi/data_fisik.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_makanan.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_olahraga.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_pilihan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'we healthy',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home_screen',
      routes: {
        'welcome_screen':(context) => WelcomeScreen(),
        'register_page':(context) => RegisterPage(),
        'login_page':(context) => LoginPage(),
        // 'pending_auth':(context) => PendingAuthPage(user: user),
        'home_screen':(context) => HomePage(),
        'splash_screen':(context) => SplashScreen(),
        'profile_page': (context) => ProfilePage(),
        'detail_bmi': (context) => bmiDetail(),
        'rekomendasi': (context) => Rekomendasi(),
        'rekomendasi_hari': (context) => rekomendasiHari(),
        'rekomendasi_makanan': (context) => rekomendasiMakanan(),
        'rekomendasi_olahraga': (context) => rekomendasiOlahraga(),
        'rekomendasi_pilihan': (context) => rekomendasiPilihan(),
        'data_fisik': (context) => DataFisik(),

      },
    );
  }
}
