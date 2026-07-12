import 'package:flutter/material.dart';

/// عنصر واحد قابل أن يكون سؤالاً أو خياراً (حرف، رقم، لون، شكل)
class QuizItem {
  final String id;
  final String display;       // ما يُعرض بصرياً (حرف/رقم/رمز شكل) أو null لو لون فقط
  final String speakAr;       // النص المنطوق بالعربي
  final String speakEn;       // النص المنطوق بالإنجليزي
  final String nameSpeakAr;   // اسم العنصر الرسمي بالعربي (لزر "ما اسمي؟" بالحروف)
  final String nameSpeakEn;
  final Color? color;         // للألوان فقط
  final IconData? icon;       // للأشكال فقط

  const QuizItem({
    required this.id,
    required this.display,
    required this.speakAr,
    required this.speakEn,
    this.nameSpeakAr = '',
    this.nameSpeakEn = '',
    this.color,
    this.icon,
  });
}
