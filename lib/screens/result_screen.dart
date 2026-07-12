import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../services/audio_service.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String category;
  final AppLanguage language;
  final AudioService audio;
  final int starsEarned;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.category,
    required this.language,
    required this.audio,
    required this.starsEarned,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(language);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 12),
              Text(s.roundComplete,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalQuestions, (i) {
                  final filled = i < starsEarned;
                  return Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 42,
                  );
                }),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => QuizScreen(category: category, language: language, audio: audio),
                  ));
                },
                child: Text(s.playAgain, style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => HomeScreen(language: language, audio: audio)),
                    (route) => false,
                  );
                },
                child: Text(s.backToHome, style: const TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
