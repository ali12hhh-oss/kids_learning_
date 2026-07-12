import 'dart:math';
import 'package:flutter/material.dart';
import '../app_strings.dart';
import '../models/quiz_item.dart';
import '../services/audio_service.dart';
import '../services/progress_service.dart';
import '../widgets/speakable_box.dart';
import '../data/category_data.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category; // 'letters' | 'numbers' | 'colors' | 'shapes'
  final AppLanguage language;
  final AudioService audio;

  const QuizScreen({
    super.key,
    required this.category,
    required this.language,
    required this.audio,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int roundLength = 5;

  late List<QuizItem> _pool;
  late AppStrings _s;
  final _progress = ProgressService();
  final _rand = Random();

  int _questionIndex = 0;
  int _starsThisRound = 0;
  bool _firstTryThisQuestion = true;

  late QuizItem _target;
  late List<QuizItem> _options;
  QuizItem? _selected;
  bool? _lastWasCorrect;

  @override
  void initState() {
    super.initState();
    _s = AppStrings(widget.language);
    _pool = _poolForCategory();
    _nextQuestion();
  }

  List<QuizItem> _poolForCategory() {
    switch (widget.category) {
      case 'letters':
        return widget.language == AppLanguage.arabic
            ? CategoryData.arabicLetters
            : CategoryData.englishLetters;
      case 'numbers':
        return CategoryData.numbers;
      case 'colors':
        return CategoryData.colors;
      case 'shapes':
        return CategoryData.shapes;
      default:
        return CategoryData.numbers;
    }
  }

  void _nextQuestion() {
    if (_questionIndex >= roundLength) {
      _finishRound();
      return;
    }
    final shuffled = List<QuizItem>.from(_pool)..shuffle(_rand);
    _target = shuffled.first;
    final distractors = shuffled.skip(1).take(3).toList();
    _options = [_target, ...distractors]..shuffle(_rand);
    _selected = null;
    _lastWasCorrect = null;
    _firstTryThisQuestion = true;
    setState(() {});
  }

  void _finishRound() {
    _progress.addStars(widget.category, _starsThisRound);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => ResultScreen(
        category: widget.category,
        language: widget.language,
        audio: widget.audio,
        starsEarned: _starsThisRound,
        totalQuestions: roundLength,
      ),
    ));
  }

  Future<void> _handleOptionTap(QuizItem option) async {
    final correct = option.id == _target.id;
    setState(() {
      _selected = option;
      _lastWasCorrect = correct;
    });

    await _progress.recordAnswer(widget.category, correct: correct);

    if (correct) {
      if (_firstTryThisQuestion) _starsThisRound++;
      await widget.audio.speak(
        widget.language == AppLanguage.arabic ? _s.correctAnswer : _s.correctAnswer,
      );
      await Future.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;
      setState(() => _questionIndex++);
      _nextQuestion();
    } else {
      _firstTryThisQuestion = false;
      await widget.audio.speak(_s.tryAgain);
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      setState(() {
        _selected = null;
        _lastWasCorrect = null;
      });
    }
  }

  Color? _feedbackFor(QuizItem item) {
    if (_selected?.id != item.id) return null;
    if (_lastWasCorrect == true) return Colors.green.shade200;
    if (_lastWasCorrect == false) return Colors.red.shade200;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7E6),
      appBar: AppBar(
        title: Text('${_s.findThis}  ${_questionIndex + 1}/$roundLength'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              _s.findThis,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 14),
            // عنصر السؤال (الهدف) — اضغط لتسمعه
            SpeakableBox(
              item: _target,
              language: widget.language,
              onSpeak: widget.audio.speak,
              size: 130,
            ),
            const SizedBox(height: 34),
            Text(_s.tapToHear, style: const TextStyle(fontSize: 13, color: Colors.black45)),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 1,
                children: _options.map((opt) {
                  return SpeakableBox(
                    item: opt,
                    language: widget.language,
                    onSpeak: widget.audio.speak,
                    onTap: () => _handleOptionTap(opt),
                    feedbackColor: _feedbackFor(opt),
                    size: 140,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
