import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_engine.dart';

class QuranQuizScreen extends StatelessWidget {
  const QuranQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> questions = [
      {
        "question": "كم عدد آيات سورة الفاتحة؟",
        "options": ["5", "6", "7", "8"],
        "answer": "7",
      },
      {
        "question": "ما هي السورة التي تُسمى (أم القرآن)؟",
        "options": ["الإخلاص", "الفاتحة", "الكوثر", "الناس"],
        "answer": "الفاتحة",
      },
      {
        "question": "كم عدد آيات سورة الإخلاص؟",
        "options": ["3", "4", "5", "6"],
        "answer": "4",
      },
      {
        "question": "ما هي أقصر سورة في القرآن؟",
        "options": ["الفاتحة", "الإخلاص", "الكوثر", "الناس"],
        "answer": "الكوثر",
      },
      {
        "question": "ما هي آخر سورة في القرآن؟",
        "options": ["الفلق", "الكوثر", "الإخلاص", "الناس"],
        "answer": "الناس",
      },
    ];

    return QuizGameEngine(
      title: "اختبار القرآن",
      questions: questions,
      optionsPool: [], // غير مستخدم لوجود خيارات مخصصة لكل سؤال
    );
  }
}