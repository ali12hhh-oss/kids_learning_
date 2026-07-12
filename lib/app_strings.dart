/// نصوص الواجهة بلغتين (عربي/إنجليزي)
/// كل النصوص المعروضة بالتطبيق تمر من هنا لسهولة الترجمة والصيانة
enum AppLanguage { arabic, english }

class AppStrings {
  final AppLanguage lang;
  AppStrings(this.lang);

  bool get isArabic => lang == AppLanguage.arabic;

  String get appName => isArabic ? 'أصدقاء التعلم' : 'Learning Friends';
  String get chooseLanguage => isArabic ? 'اختر اللغة' : 'Choose Language';
  String get arabic => 'العربية';
  String get english => 'English';

  String get homeLetters => isArabic ? 'الحروف' : 'Letters';
  String get homeNumbers => isArabic ? 'الأرقام' : 'Numbers';
  String get homeColors => isArabic ? 'الألوان' : 'Colors';
  String get homeShapes => isArabic ? 'الأشكال' : 'Shapes';
  String get homeAchievements => isArabic ? 'إنجازاتي' : 'My Achievements';
  String get homeParents => isArabic ? 'أولياء الأمور' : 'Parents';

  String get whatIsMyName => isArabic ? 'ما اسمي؟' : "What's my name?";
  String get tapToHear => isArabic ? 'اضغط لتسمع' : 'Tap to hear';
  String get findThis => isArabic ? 'اضغط على' : 'Find';

  String get correctAnswer => isArabic ? 'أحسنت! 🎉' : 'Great job! 🎉';
  String get tryAgain => isArabic ? 'حاول مرة ثانية!' : 'Try again!';

  String get roundComplete => isArabic ? 'أحسنت! أنهيت الجولة' : 'Round complete!';
  String get backToHome => isArabic ? 'الرئيسية' : 'Home';
  String get playAgain => isArabic ? 'العب مرة ثانية' : 'Play again';

  String get achievementsTitle => isArabic ? 'إنجازاتي' : 'My Achievements';
  String get starsEarned => isArabic ? 'نجوم مكتسبة' : 'Stars earned';

  String get parentGateTitle => isArabic ? 'بوابة الوالدين' : 'Parent Gate';
  String get parentGateInstruction =>
      isArabic ? 'حل السؤال للدخول (هذا للوالدين فقط)' : 'Solve to continue (parents only)';
  String get wrongTryAgain => isArabic ? 'إجابة خاطئة، حاول ثانية' : 'Wrong, try again';

  String get parentDashboardTitle => isArabic ? 'لوحة متابعة التقدم' : 'Progress Dashboard';
  String get totalCorrect => isArabic ? 'إجابات صحيحة' : 'Correct answers';
  String get totalAttempts => isArabic ? 'إجمالي المحاولات' : 'Total attempts';
  String get accuracy => isArabic ? 'نسبة الإتقان' : 'Accuracy';
  String get lastPlayed => isArabic ? 'آخر استخدام' : 'Last played';
  String get noDataYet => isArabic ? 'لا توجد بيانات بعد' : 'No data yet';
  String get resetProgress => isArabic ? 'إعادة تعيين التقدم' : 'Reset progress';
}
