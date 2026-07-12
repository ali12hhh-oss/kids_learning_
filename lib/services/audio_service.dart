import 'package:flutter_tts/flutter_tts.dart';
import '../app_strings.dart';

/// خدمة النطق الصوتي — تنطق أي نص عند الطلب (عند الضغط فقط، أبداً تلقائياً)
/// تعتمد على محرك تحويل النص لصوت المدمج بنظام التشغيل (Text-to-Speech)
///
/// ملاحظة صادقة مهمة: محرك TTS العام ينطق "اسم" الحرف وليس "صوته الصوتي"
/// المنفصل (مثل نطق /b/ الصوتي بدل "بي" أو "الباء"). لتفعيل الصوتيات
/// (Phonics) الدقيقة لاحقاً، يُفضّل استبدال هذه الخدمة بملفات صوتية
/// مسجّلة فعلياً لكل حرف — هذا موضّح كخطوة مستقبلية في README.
class AudioService {
  final FlutterTts _tts = FlutterTts();
  AppLanguage _language = AppLanguage.arabic;

  Future<void> init(AppLanguage language) async {
    _language = language;
    await _applyLocale();
    await _tts.setPitch(1.1);
    await _tts.setSpeechRate(0.42);
  }

  Future<void> setLanguage(AppLanguage language) async {
    _language = language;
    await _applyLocale();
  }

  Future<void> _applyLocale() async {
    await _tts.setLanguage(_language == AppLanguage.arabic ? 'ar-SA' : 'en-US');
  }

  Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
