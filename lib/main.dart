import 'package:flutter/material.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';

void main() {
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
      home: LoginPage(),
    );
  }
}
