import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_engine.dart';


class ChooseLetterGame extends StatelessWidget {
  const ChooseLetterGame({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizGameEngine(
      title: "اختبار الحروف 🧩",
      questions: const [
        {"question": "أسد", "answer": "أ"},
        {"question": "بطة", "answer": "ب"},
        {"question": "تفاح", "answer": "ت"},
        {"question": "ثعلب", "answer": "ث"},
        {"question": "جمل", "answer": "ج"},
      ],
      optionsPool: const ["أ","ب","ت","ث","ج","ح","خ","د","ذ","ر"],
    );
  }
}