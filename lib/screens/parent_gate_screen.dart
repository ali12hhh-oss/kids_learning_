import 'dart:math';
import 'package:flutter/material.dart';
import '../app_strings.dart';
import 'parent_dashboard_screen.dart';

/// بوابة حماية بسيطة قبل الوصول للوحة الوالدين
/// سؤال حسابي عشوائي يصعب على طفل صغير حله بسرعة، لكنه بسيط لبالغ
class ParentGateScreen extends StatefulWidget {
  final AppLanguage language;
  const ParentGateScreen({super.key, required this.language});

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  late int _a, _b, _correctAnswer;
  late List<int> _options;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final rand = Random();
    _a = 4 + rand.nextInt(6); // 4-9
    _b = 3 + rand.nextInt(6); // 3-8
    _correctAnswer = _a + _b;
    final wrongs = <int>{};
    while (wrongs.length < 3) {
      final w = _correctAnswer + (rand.nextInt(7) - 3);
      if (w != _correctAnswer && w > 0) wrongs.add(w);
    }
    _options = [_correctAnswer, ...wrongs]..shuffle(rand);
    _error = null;
  }

  void _check(int value) {
    if (value == _correctAnswer) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ParentDashboardScreen(language: widget.language),
      ));
    } else {
      setState(() {
        _error = AppStrings(widget.language).wrongTryAgain;
        _generateQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(widget.language);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      appBar: AppBar(
        title: Text(s.parentGateTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(s.parentGateInstruction, style: const TextStyle(fontSize: 15, color: Colors.black54)),
              const SizedBox(height: 24),
              Text('$_a + $_b = ?', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const SizedBox(height: 26),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: _options.map((opt) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                      backgroundColor: Colors.deepPurple.shade50,
                      foregroundColor: Colors.deepPurple,
                    ),
                    onPressed: () => _check(opt),
                    child: Text('$opt', style: const TextStyle(fontSize: 20)),
                  );
                }).toList(),
              ),
              if (_error != null) ...[
                const SizedBox(height: 20),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
