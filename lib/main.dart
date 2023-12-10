import 'package:flutter/material.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_hari.dart';
import 'package:we_healthy/screen/splash_screen.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return const MaterialApp(
      title: 'we healthy',
      debugShowCheckedModeBanner: false,
      home: rekomendasiMakanan(),
    );
  }
}
