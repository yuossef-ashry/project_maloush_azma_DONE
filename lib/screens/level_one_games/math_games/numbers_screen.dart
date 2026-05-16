import 'package:flutter/material.dart';
import '../../common/widgets/learning_game_screen.dart';

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningGameScreen(
      title: "تعلم الأرقام",

      mainColor: Colors.deepPurple,

      items: const [
        {
          "main": "1",
          "word": "واحد",
          "emoji": "1️⃣",
          "sound": "1",
        },

        {
          "main": "2",
          "word": "اثنين",
          "emoji": "2️⃣",
          "sound": "2",
        },

        {
          "main": "3",
          "word": "ثلاثة",
          "emoji": "3️⃣",
          "sound": "3",
        },

        {
          "main": "4",
          "word": "أربعة",
          "emoji": "4️⃣",
          "sound": "4",
        },

        {
          "main": "5",
          "word": "خمسة",
          "emoji": "5️⃣",
          "sound": "5",
        },

        {
          "main": "6",
          "word": "ستة",
          "emoji": "6️⃣",
          "sound": "6",
        },

        {
          "main": "7",
          "word": "سبعة",
          "emoji": "7️⃣",
          "sound": "7",
        },

        {
          "main": "8",
          "word": "ثمانية",
          "emoji": "8️⃣",
          "sound": "8",
        },

        {
          "main": "9",
          "word": "تسعة",
          "emoji": "9️⃣",
          "sound": "9",
        },

        {
          "main": "10",
          "word": "عشرة",
          "emoji": "🔟",
          "sound": "10",
        },
      ],
    );
  }
}