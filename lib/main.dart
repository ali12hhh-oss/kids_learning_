import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KidsLearningApp());
}

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أصدقاء التعلم | Learning Friends',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Tajawal',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
