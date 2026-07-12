import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../services/audio_service.dart';
import '../services/progress_service.dart';
import 'home_screen.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  Future<void> _select(BuildContext context, AppLanguage lang) async {
    final audio = AudioService();
    await audio.init(lang);
    final progress = ProgressService();
    await progress.saveLanguage(lang == AppLanguage.arabic ? 'ar' : 'en');
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => HomeScreen(language: lang, audio: audio),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🌟', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 12),
              const Text('اختر اللغة  /  Choose Language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => _select(context, AppLanguage.arabic),
                child: const Text('العربية'),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.deepPurple.shade300,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => _select(context, AppLanguage.english),
                child: const Text('English'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
