import 'package:flutter/material.dart';
import '../models/quiz_item.dart';
import '../app_strings.dart';

/// المكوّن الموحّد القابل لإعادة الاستخدام: أي عنصر بالتطبيق (حرف/رقم/
/// لون/شكل) يُعرض بهذا الشكل، وينطق صوته فقط عند الضغط عليه — أبداً تلقائياً.
class SpeakableBox extends StatefulWidget {
  final QuizItem item;
  final AppLanguage language;
  final void Function(String text) onSpeak;
  final VoidCallback? onTap; // منطق إضافي عند الضغط (مثل اختيار إجابة)
  final double size;
  final bool selected;
  final Color? feedbackColor; // لتلوين مؤقت (أخضر/أحمر) عند الإجابة

  const SpeakableBox({
    super.key,
    required this.item,
    required this.language,
    required this.onSpeak,
    this.onTap,
    this.size = 120,
    this.selected = false,
    this.feedbackColor,
  });

  @override
  State<SpeakableBox> createState() => _SpeakableBoxState();
}

class _SpeakableBoxState extends State<SpeakableBox> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    final text = widget.language == AppLanguage.arabic ? widget.item.speakAr : widget.item.speakEn;
    widget.onSpeak(text);
    _pulseController.forward().then((_) => _pulseController.reverse());
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 1.0 + _pulseController.value;
          return Transform.scale(scale: scale, child: child);
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: item.color ?? (widget.feedbackColor ?? Colors.white),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selected ? Colors.amber : Colors.black12,
              width: widget.selected ? 4 : 2,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          alignment: Alignment.center,
          child: _buildContent(item),
        ),
      ),
    );
  }

  Widget _buildContent(QuizItem item) {
    if (item.icon != null) {
      return Icon(item.icon, size: widget.size * 0.55, color: Colors.indigo);
    }
    if (item.display.isNotEmpty) {
      return Text(
        item.display,
        style: TextStyle(fontSize: widget.size * 0.45, fontWeight: FontWeight.bold),
      );
    }
    // لون فقط بدون نص ولا أيقونة
    return const SizedBox.shrink();
  }
}
