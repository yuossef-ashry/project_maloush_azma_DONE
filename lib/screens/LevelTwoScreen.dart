import 'package:flutter/material.dart';

import 'base_level_screen.dart';

import 'level_one_games/Arabic_games/spelling_game_screen.dart';
import 'level_two_games/arabic_games_2/months_screen.dart';
import 'level_two_games/arabic_games_2/drag_drop_screen.dart';
import 'level_two_games/arabic_games_2/quran_screen.dart';
import 'level_two_games/arabic_games_2/quran_quiz_screen.dart';

import 'level_two_games/math_games_2/addition_game_screen.dart';
import 'level_two_games/math_games_2/subtraction_game_screen.dart';
import 'level_two_games/math_games_2/multiplication_game_screen.dart';
import 'level_two_games/math_games_2/division_game_screen.dart';

class LevelTwoScreen extends StatelessWidget {
  const LevelTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLevelScreen(
      title: "المستوى الثاني - المدرسة",

      arabicItems: [
        {
          "title": "السحب والإفلات",
          "image": "assets/images/10.jpeg",
          "page": EmojiDragDropGame(), // ✔ بدون const
          "color": Colors.green,
        },
        {
          "title": "شهور السنة",
          "image": "assets/images/11.jpeg",
          "page": const MonthsScreen(),
          "color": Colors.red,
        },
        {
          "title": "القرآن الكريم",
          "image": "assets/images/12.jpeg",
          "page": const QuranScreen(),
          "color": Colors.teal,
        },
        {
          "title": "اختبار القرآن",
          "image": "assets/images/55.jpeg",
          "page": const QuranQuizScreen(),
          "color": Colors.indigo,
        },
      ],

      mathItems: [
        {
          "title": "الجمع",
          "image": "assets/images/14.png",
          "page": const AdditionGameScreen(),
          "color": Colors.blue,
        },
        {
          "title": "الطرح",
          "image": "assets/images/17.png",
          "page": const SubtractionGameScreen(),
          "color": Colors.purple,
        },
        {
          "title": "الضرب",
          "image": "assets/images/15.png",
          "page": const MultiplicationGameScreen(),
          "color": Colors.red,
        },
        {
          "title": "القسمة",
          "image": "assets/images/16.png",
          "page": const DivisionGameScreen(),
          "color": Colors.green,
        },
      ],
    );
  }
}