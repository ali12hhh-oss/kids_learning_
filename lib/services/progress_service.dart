import 'package:shared_preferences/shared_preferences.dart';

/// خدمة تخزين تقدم الطفل محلياً على الجهاز (بدون إنترنت أو حسابات)
class CategoryStats {
  final int correct;
  final int attempts;
  final int stars;
  final String lastPlayed; // ISO date string, فارغ إن لم يُلعب بعد

  CategoryStats({
    required this.correct,
    required this.attempts,
    required this.stars,
    required this.lastPlayed,
  });

  double get accuracy => attempts == 0 ? 0 : (correct / attempts) * 100;
}

class ProgressService {
  static const _categories = ['letters', 'numbers', 'colors', 'shapes'];

  Future<void> recordAnswer(String category, {required bool correct}) async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = (prefs.getInt('${category}_attempts') ?? 0) + 1;
    final correctCount = (prefs.getInt('${category}_correct') ?? 0) + (correct ? 1 : 0);
    await prefs.setInt('${category}_attempts', attempts);
    await prefs.setInt('${category}_correct', correctCount);
    await prefs.setString('${category}_lastPlayed', DateTime.now().toIso8601String());
  }

  Future<void> addStars(String category, int count) async {
    final prefs = await SharedPreferences.getInstance();
    final stars = (prefs.getInt('${category}_stars') ?? 0) + count;
    await prefs.setInt('${category}_stars', stars);
  }

  Future<CategoryStats> getStats(String category) async {
    final prefs = await SharedPreferences.getInstance();
    return CategoryStats(
      correct: prefs.getInt('${category}_correct') ?? 0,
      attempts: prefs.getInt('${category}_attempts') ?? 0,
      stars: prefs.getInt('${category}_stars') ?? 0,
      lastPlayed: prefs.getString('${category}_lastPlayed') ?? '',
    );
  }

  Future<Map<String, CategoryStats>> getAllStats() async {
    final Map<String, CategoryStats> result = {};
    for (final c in _categories) {
      result[c] = await getStats(c);
    }
    return result;
  }

  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    for (final c in _categories) {
      await prefs.remove('${c}_attempts');
      await prefs.remove('${c}_correct');
      await prefs.remove('${c}_stars');
      await prefs.remove('${c}_lastPlayed');
    }
  }

  Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', langCode);
  }

  Future<String?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('app_language');
  }
}
