import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_engine.dart';

class ChooseAnswerScreen extends StatelessWidget {
  const ChooseAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تحويل الأسئلة إلى الصيغة التي يفهمها QuizGameEngine
    final List<Map<String, dynamic>> questions = [
      {
        "image": "🌵",
        "question": "أي حيوان يعيش في الصحراء؟",
        "options": ["قرد ", "جمل", "بطة ", "أرنب "],
        "answer": "جمل",  // engine يستخدم "answer" بدلاً من "correctOption"
      },
      {
        "image": "🍎",
        "question": "ما هو لون التفاحة؟",
        "options": ["أزرق", "أحمر", "أصفر", "أخضر"],
        "answer": "أحمر",
      },
      {
        "image": "🌊",
        "question": "ما هو حيوان البحر؟",
        "options": ["سمكة ", "أسد ", "فيل ", "ذئب "],
        "answer": "سمكة ",
      },
    ];

    return QuizGameEngine(
      title: "اختر الإجابة الصحيحة",
      questions: questions,
      optionsPool: [], // غير مستخدم لأن كل سؤال يحدد خياراته بنفسه
    );
  }
}