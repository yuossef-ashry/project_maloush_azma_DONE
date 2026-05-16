import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_engine.dart';

class SpellingGameScreen extends StatelessWidget {
  const SpellingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizGameEngine(
      title: "الإملاء ✍️",
      questions: const [
        {
          "question": "تف؟حة 🍎",
          "answer": "ا",
          "options": ["ا", "و", "ي", "ة"]
        },
        {
          "question": "أ؟د 🦁",
          "answer": "س",
          "options": ["ب", "س", "ك", "ن"]
        },
        {
          "question": "ف؟ل 🐘",
          "answer": "ي",
          "options": ["ا", "و", "ي", "ة"]
        },
      ],
      optionsPool: const [], // مش مهم هنا
    );
  }
}