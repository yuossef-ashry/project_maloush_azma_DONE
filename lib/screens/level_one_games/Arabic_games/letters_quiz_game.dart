import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_screen.dart';

class LettersQuizGame extends StatelessWidget {

  const LettersQuizGame({super.key});

  @override
  Widget build(BuildContext context) {

    return QuizGameScreen(

      title: "اختبار الحروف 🎧",

      showEmoji: true,

      optionsPool: const [
        "أ","ب","ت","ث","ج","ح","خ","د",
        "ذ","ر","ز","س","ش","ص","ض","ط",
        "ظ","ع","غ","ف","ق","ك","ل","م",
        "ن","ه","و","ي"
      ],

      questions: const [

        {"emoji": "🦁", "answer": "أ", "sound": "1.mp3"},
        {"emoji": "🍎", "answer": "ت", "sound": "2.mp3"},
        {"emoji": "🐘", "answer": "ف", "sound": "3.mp3"},
        {"emoji": "🌹", "answer": "و", "sound": "4.mp3"},
      ],
    );
  }
}