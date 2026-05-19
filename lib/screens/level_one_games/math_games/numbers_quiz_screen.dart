import 'package:flutter/material.dart';
import '../../common/widgets/quiz_game_screen.dart';

class NumbersQuizScreen extends StatelessWidget {

  const NumbersQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return QuizGameScreen(

      title: "اختبار الأرقام 🎧",

      showEmoji: false,

      optionsPool: const [
        "1","2","3","4","5",
        "6","7","8","9","10"
      ],

      questions: const [

        {"emoji": "👆","number": "1", "sound": "1.mp3"},
        {"emoji": "✌️","number": "2", "sound": "2.mp3"},
        {"emoji": "🤟","number": "3", "sound": "3.mp3"},
        {"emoji": "🖐️","number": "4", "sound": "4.mp3"},
        {"number": "1", "sound": "1.mp3"},
        {"number": "2", "sound": "2.mp3"},
        {"number": "3", "sound": "3.mp3"},
        {"number": "4", "sound": "4.mp3"},
      ],
    );
  }
}