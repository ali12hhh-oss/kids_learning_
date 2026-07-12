import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../services/progress_service.dart';

class AchievementsScreen extends StatelessWidget {
  final AppLanguage language;
  const AchievementsScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(language);
    final progress = ProgressService();
    final categories = [
      ('letters', s.homeLetters, '🔤'),
      ('numbers', s.homeNumbers, '🔢'),
      ('colors', s.homeColors, '🎨'),
      ('shapes', s.homeShapes, '🔺'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      appBar: AppBar(
        title: Text(s.achievementsTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, CategoryStats>>(
        future: progress.getAllStats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final stats = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: categories.map((c) {
              final st = stats[c.$1]!;
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  leading: Text(c.$3, style: const TextStyle(fontSize: 30)),
                  title: Text(c.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${st.stars}', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
