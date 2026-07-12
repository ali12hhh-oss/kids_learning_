import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../services/progress_service.dart';

class ParentDashboardScreen extends StatefulWidget {
  final AppLanguage language;
  const ParentDashboardScreen({super.key, required this.language});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  final _progress = ProgressService();
  late Future<Map<String, CategoryStats>> _future;

  @override
  void initState() {
    super.initState();
    _future = _progress.getAllStats();
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '-';
    final d = DateTime.tryParse(iso);
    if (d == null) return '-';
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(widget.language);
    final categories = [
      ('letters', s.homeLetters),
      ('numbers', s.homeNumbers),
      ('colors', s.homeColors),
      ('shapes', s.homeShapes),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      appBar: AppBar(
        title: Text(s.parentDashboardTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, CategoryStats>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final stats = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ...categories.map((c) {
                final st = stats[c.$1]!;
                if (st.attempts == 0) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: ListTile(
                      title: Text(c.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(s.noDataYet),
                    ),
                  );
                }
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.$2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: st.accuracy / 100,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 8),
                        Text('${s.totalCorrect}: ${st.correct}'),
                        Text('${s.totalAttempts}: ${st.attempts}'),
                        Text('${s.accuracy}: ${st.accuracy.toStringAsFixed(0)}%'),
                        Text('${s.lastPlayed}: ${_formatDate(st.lastPlayed)}'),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh, color: Colors.red),
                label: Text(s.resetProgress, style: const TextStyle(color: Colors.red)),
                onPressed: () async {
                  await _progress.resetAll();
                  setState(() => _future = _progress.getAllStats());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
