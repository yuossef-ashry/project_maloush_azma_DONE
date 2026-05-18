import 'package:flutter/material.dart';

import 'base_level_screen.dart';

import '../screens/level_one_games/Arabic_games/letters_game.dart';
import '../screens/level_one_games/Arabic_games/letters_quiz_game.dart';
import '../screens/level_one_games/Arabic_games/spelling_game_screen.dart';
import '../screens/level_one_games/Arabic_games/shapes_game.dart';

import '../screens/level_one_games/math_games/numbers_screen.dart';
import '../screens/level_one_games/math_games/choose_number_screen.dart';
import '../screens/level_one_games/math_games/shapes_game_number.dart';
import '../screens/level_one_games/math_games/numbers_quiz_screen.dart';


class LevelOneScreen extends StatelessWidget {
  const LevelOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLevelScreen(
      title: "المستوى الأول - الروضة",

      arabicItems: [
        {
          "title": "الحروف العربية",
          "image": "assets/images/1.jpeg",
          "page": LettersGame(),
          "color": Colors.orange,
        },
        {
          "title": "اختبار الحروف",
          "image": "assets/images/2.jpeg",
          "page": LettersQuizGame(),
          "color": Colors.blue,
        },
        {
          "title": "الإملاء ✍️",
          "image": "assets/images/9.jpeg",
          "page": SpellingGameScreen(),
          "color": Colors.deepOrange,
        },
        {
          "title": "توصيل الأشكال",
          "image": "assets/images/4.jpeg",
          "page": ShapesGame(),
          "color": Colors.green,
        },
      ],

      mathItems: [
        {
          "title": "الأرقام",
          "image": "assets/images/5.jpeg",
          "page": NumbersScreen(),
          "color": Colors.orange,
        },
        {
          "title": "اختبار الأرقام",
          "image": "assets/images/8.jpeg",
          "page": NumbersQuizScreen(),
          "color": Colors.red,
        },
        {
          "title": "اختر الرقم الصحيح",
          "image": "assets/images/7.jpeg",
          "page": const ChooseNumberGame(),
          "color": Colors.blue,
        },

        {
          "title": "صل الصورة بالرقم",
          "image": "assets/images/6.jpeg",
          "page": NumbersGame(),
          "color": Colors.purple,
        },
      ],
    );
  }
}