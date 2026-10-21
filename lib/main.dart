import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

void main() {
  runApp(const CityPulseApp());
}

class CityPulseApp extends StatelessWidget {
  const CityPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CityPulse',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),

      // Common Login/Register entry point
      home: const LoginScreen(),
    );
  }
}