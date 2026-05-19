import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_engine.dart';


class ChooseNumberGame extends StatelessWidget {
  const ChooseNumberGame({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizGameEngine(
      title: "اختبار الأرقام 🔢",
      questions: const [
        {"question": "واحد", "answer": "1"},
        {"question": "اثنين", "answer": "2"},
        {"question": "ثلاثة", "answer": "3"},
        {"question": "أربعة", "answer": "4"},

        {"question": "خمسة", "answer": "5"},
      ],
      optionsPool: const ["1","2","3","4","5","6","7","8"],
    );
  }
}