import 'package:flutter/material.dart';

// 📌 استيراد الشاشات

import 'package:teaching_children/screens/level_two_games/math_games_2/addition_game_screen.dart';
import 'package:teaching_children/screens/level_two_games/math_games_2/subtraction_game_screen.dart';
import 'package:teaching_children/screens/level_two_games/math_games_2/multiplication_game_screen.dart';
import 'package:teaching_children/screens/level_two_games/math_games_2/division_game_screen.dart';

class LevelTwoMathScreen extends StatelessWidget {
  LevelTwoMathScreen({super.key});

  final List<Map<String, dynamic>> items = [

    {
      "title": "الجمع",
      "image": "assets/images/14.jpeg",
      "color": Colors.blue,
      "screen": AdditionGameScreen(),
    },
    {
      "title": "الطرح",
      "image": "assets/images/17.jpeg",
      "color": Colors.purple,
      "screen": SubtractionGameScreen(),
    },
    {
      "title": "الضرب",
      "image": "assets/images/15.jpeg",
      "color": Colors.red,
      "screen": MultiplicationGameScreen(),
    },
    {
      "title": "القسمة",
      "image": "assets/images/16.jpeg",
      "color": Colors.green,
      "screen": DivisionGameScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF81C784)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 30),

              /// ⭐ العنوان
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 25,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: const Text(
                  "المستوى الثاني - رياضيات",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// 📦 الجريد
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  child: GridView.builder(
                    itemCount: items.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.85,
                    ),

                    itemBuilder: (context, index) {
                      final item = items[index];

                      return buildCard(context, item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🎴 الكروت
  Widget buildCard(
      BuildContext context,
      Map<String, dynamic> item,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => item["screen"],
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: item["color"],
          borderRadius: BorderRadius.circular(30),

          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// 🟢 الصورة الدائرية
            Container(
              width: 85,
              height: 85,

              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              child: Padding(
                padding: const EdgeInsets.all(10),

                child: Image.asset(
                  item["image"],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📝 العنوان
            Text(
              item["title"],
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}