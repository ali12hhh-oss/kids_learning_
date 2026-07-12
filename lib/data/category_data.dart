import 'package:flutter/material.dart';
import '../models/quiz_item.dart';

/// بنك عناصر كل محور تعليمي
class CategoryData {
  // ===== الحروف العربية (28 حرف) =====
  static const List<QuizItem> arabicLetters = [
    QuizItem(id: 'ar_alif', display: 'ا', speakAr: 'ا', speakEn: 'Alif', nameSpeakAr: 'حرف الألف'),
    QuizItem(id: 'ar_ba', display: 'ب', speakAr: 'ب', speakEn: 'Ba', nameSpeakAr: 'حرف الباء'),
    QuizItem(id: 'ar_ta', display: 'ت', speakAr: 'ت', speakEn: 'Ta', nameSpeakAr: 'حرف التاء'),
    QuizItem(id: 'ar_tha', display: 'ث', speakAr: 'ث', speakEn: 'Tha', nameSpeakAr: 'حرف الثاء'),
    QuizItem(id: 'ar_jim', display: 'ج', speakAr: 'ج', speakEn: 'Jeem', nameSpeakAr: 'حرف الجيم'),
    QuizItem(id: 'ar_ha2', display: 'ح', speakAr: 'ح', speakEn: 'Ha', nameSpeakAr: 'حرف الحاء'),
    QuizItem(id: 'ar_kha', display: 'خ', speakAr: 'خ', speakEn: 'Kha', nameSpeakAr: 'حرف الخاء'),
    QuizItem(id: 'ar_dal', display: 'د', speakAr: 'د', speakEn: 'Dal', nameSpeakAr: 'حرف الدال'),
    QuizItem(id: 'ar_thal', display: 'ذ', speakAr: 'ذ', speakEn: 'Thal', nameSpeakAr: 'حرف الذال'),
    QuizItem(id: 'ar_ra', display: 'ر', speakAr: 'ر', speakEn: 'Ra', nameSpeakAr: 'حرف الراء'),
    QuizItem(id: 'ar_zay', display: 'ز', speakAr: 'ز', speakEn: 'Zay', nameSpeakAr: 'حرف الزاي'),
    QuizItem(id: 'ar_sin', display: 'س', speakAr: 'س', speakEn: 'Seen', nameSpeakAr: 'حرف السين'),
    QuizItem(id: 'ar_shin', display: 'ش', speakAr: 'ش', speakEn: 'Sheen', nameSpeakAr: 'حرف الشين'),
    QuizItem(id: 'ar_sad', display: 'ص', speakAr: 'ص', speakEn: 'Sad', nameSpeakAr: 'حرف الصاد'),
    QuizItem(id: 'ar_dad', display: 'ض', speakAr: 'ض', speakEn: 'Dad', nameSpeakAr: 'حرف الضاد'),
    QuizItem(id: 'ar_ta2', display: 'ط', speakAr: 'ط', speakEn: 'Ta2', nameSpeakAr: 'حرف الطاء'),
    QuizItem(id: 'ar_dha', display: 'ظ', speakAr: 'ظ', speakEn: 'Dha', nameSpeakAr: 'حرف الظاء'),
    QuizItem(id: 'ar_ain', display: 'ع', speakAr: 'ع', speakEn: 'Ain', nameSpeakAr: 'حرف العين'),
    QuizItem(id: 'ar_ghain', display: 'غ', speakAr: 'غ', speakEn: 'Ghain', nameSpeakAr: 'حرف الغين'),
    QuizItem(id: 'ar_fa', display: 'ف', speakAr: 'ف', speakEn: 'Fa', nameSpeakAr: 'حرف الفاء'),
    QuizItem(id: 'ar_qaf', display: 'ق', speakAr: 'ق', speakEn: 'Qaf', nameSpeakAr: 'حرف القاف'),
    QuizItem(id: 'ar_kaf', display: 'ك', speakAr: 'ك', speakEn: 'Kaf', nameSpeakAr: 'حرف الكاف'),
    QuizItem(id: 'ar_lam', display: 'ل', speakAr: 'ل', speakEn: 'Lam', nameSpeakAr: 'حرف اللام'),
    QuizItem(id: 'ar_mim', display: 'م', speakAr: 'م', speakEn: 'Meem', nameSpeakAr: 'حرف الميم'),
    QuizItem(id: 'ar_nun', display: 'ن', speakAr: 'ن', speakEn: 'Noon', nameSpeakAr: 'حرف النون'),
    QuizItem(id: 'ar_ha', display: 'ه', speakAr: 'ه', speakEn: 'Ha2', nameSpeakAr: 'حرف الهاء'),
    QuizItem(id: 'ar_waw', display: 'و', speakAr: 'و', speakEn: 'Waw', nameSpeakAr: 'حرف الواو'),
    QuizItem(id: 'ar_ya', display: 'ي', speakAr: 'ي', speakEn: 'Ya', nameSpeakAr: 'حرف الياء'),
  ];

  // ===== الحروف الإنجليزية (26 حرف) =====
  static List<QuizItem> get englishLetters => List.generate(26, (i) {
        final letter = String.fromCharCode(65 + i);
        return QuizItem(
          id: 'en_${letter.toLowerCase()}',
          display: letter,
          speakAr: letter,
          speakEn: letter,
          nameSpeakEn: 'The letter $letter',
        );
      });

  // ===== الأرقام (1-10) =====
  static const List<String> _numberWordsAr = [
    'واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة', 'ثمانية', 'تسعة', 'عشرة'
  ];
  static const List<String> _numberWordsEn = [
    'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
  ];
  static List<QuizItem> get numbers => List.generate(10, (i) {
        final n = i + 1;
        return QuizItem(
          id: 'num_$n',
          display: '$n',
          speakAr: _numberWordsAr[i],
          speakEn: _numberWordsEn[i],
        );
      });

  // ===== الألوان =====
  static const List<QuizItem> colors = [
    QuizItem(id: 'col_red', display: '', speakAr: 'أحمر', speakEn: 'Red', color: Colors.red),
    QuizItem(id: 'col_blue', display: '', speakAr: 'أزرق', speakEn: 'Blue', color: Colors.blue),
    QuizItem(id: 'col_green', display: '', speakAr: 'أخضر', speakEn: 'Green', color: Colors.green),
    QuizItem(id: 'col_yellow', display: '', speakAr: 'أصفر', speakEn: 'Yellow', color: Colors.yellow),
    QuizItem(id: 'col_orange', display: '', speakAr: 'برتقالي', speakEn: 'Orange', color: Colors.orange),
    QuizItem(id: 'col_purple', display: '', speakAr: 'بنفسجي', speakEn: 'Purple', color: Colors.purple),
    QuizItem(id: 'col_pink', display: '', speakAr: 'وردي', speakEn: 'Pink', color: Colors.pink),
    QuizItem(id: 'col_brown', display: '', speakAr: 'بني', speakEn: 'Brown', color: Colors.brown),
  ];

  // ===== الأشكال =====
  static const List<QuizItem> shapes = [
    QuizItem(id: 'shp_circle', display: '', speakAr: 'دائرة', speakEn: 'Circle', icon: Icons.circle),
    QuizItem(id: 'shp_square', display: '', speakAr: 'مربع', speakEn: 'Square', icon: Icons.square),
    QuizItem(id: 'shp_triangle', display: '', speakAr: 'مثلث', speakEn: 'Triangle', icon: Icons.change_history),
    QuizItem(id: 'shp_rect', display: '', speakAr: 'مستطيل', speakEn: 'Rectangle', icon: Icons.crop_landscape),
    QuizItem(id: 'shp_star', display: '', speakAr: 'نجمة', speakEn: 'Star', icon: Icons.star),
    QuizItem(id: 'shp_heart', display: '', speakAr: 'قلب', speakEn: 'Heart', icon: Icons.favorite),
  ];
}
