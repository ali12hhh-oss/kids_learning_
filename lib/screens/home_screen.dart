import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../services/audio_service.dart';
import 'quiz_screen.dart';
import 'achievements_screen.dart';
import 'parent_gate_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppLanguage language;
  final AudioService audio;

  const HomeScreen({super.key, required this.language, required this.audio});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(language);
    final tiles = [
      _Tile(s.homeLetters, '🔤', Colors.orange, 'letters'),
      _Tile(s.homeNumbers, '🔢', Colors.blue, 'numbers'),
      _Tile(s.homeColors, '🎨', Colors.pink, 'colors'),
      _Tile(s.homeShapes, '🔺', Colors.teal, 'shapes'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      appBar: AppBar(
        title: Text(s.appName),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            tooltip: s.homeAchievements,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AchievementsScreen(language: language),
            )),
          ),
          IconButton(
            icon: const Icon(Icons.family_restroom),
            tooltip: s.homeParents,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ParentGateScreen(language: language),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: tiles.map((t) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => QuizScreen(category: t.category, language: language, audio: audio),
              )),
              child: Container(
                decoration: BoxDecoration(
                  color: t.color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: t.color, width: 2),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.emoji, style: const TextStyle(fontSize: 48)),
                    const SizedBox(height: 10),
                    Text(t.label,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: t.color.withOpacity(0.9))),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _Tile {
  final String label;
  final String emoji;
  final Color color;
  final String category;
  _Tile(this.label, this.emoji, this.color, this.category);
}
