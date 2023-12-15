import 'package:flutter/material.dart';
import 'package:we_healthy/screen/detail_bmi.dart';
import 'package:we_healthy/screen/home_screen.dart';
import 'package:we_healthy/screen/profile_page.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_hari_makanan.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_hari_olahraga.dart';
import 'package:we_healthy/screen/splash_screen.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:we_healthy/screen/user_auth/register_page.dart';
import 'package:we_healthy/screen/welcome_page.dart';
import 'firebase_options.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'we healthy',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'register_page': (context) => RegisterPage(),
        'login_page': (context) => LoginPage(),
        'home_screen': (context) => HomePage(),
        'splash_screen': (context) => SplashScreen(),
        'profile_page': (context) => ProfilePage(),
        'detail_bmi': (context) => BmiDetail(),
        'rekomendasi': (context) => Rekomendasi(),
        'rekomendasi_hari_makan': (context) => RekomendasiHariMakanan(),
        'rekomendasi_hari_olahraga': (context) => RekomendasiHariOlahraga(),
        'rekomendasi_makanan': (context) => RekomendasiMakanan(),
        'rekomendasi_olahraga': (context) => RekomendasiOlahraga(),
        'rekomendasi_pilihan': (context) => RekomendasiPilihan(),
      },
    );
  }
}
