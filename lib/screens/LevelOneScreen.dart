import 'package:flutter/material.dart';

import '../screens/level_one_games/Arabic_games/letters_game.dart';
import '../screens/level_one_games/Arabic_games/letters_quiz_game.dart';
import '../screens/level_one_games/Arabic_games/shapes_game.dart';
import '../screens/level_one_games/Arabic_games/spelling_game_screen.dart';

import '../screens/level_one_games/math_games/numbers_screen.dart';
import '../screens/level_one_games/math_games/choose_number_screen.dart';
import '../screens/level_one_games/math_games/numbers_quiz_screen.dart';
import '../screens/level_one_games/math_games/shapes_game_number.dart';

class LevelOneScreen extends StatefulWidget {
  const LevelOneScreen({super.key});

  @override
  State<LevelOneScreen> createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> arabicItems = [
    {"title": "الحروف العربية", "image": "assets/images/1.jpeg", "page": const LettersGame(), "color": Colors.orange},
    {"title": "اختبار الحروف", "image": "assets/images/2.jpeg", "page": const LettersQuizGame(), "color": Colors.blue},
    {"title": "توصيل الأشكال", "image": "assets/images/4.jpeg", "page": const ShapesGame(), "color": Colors.green},
    {"title": "الإملاء ✍️", "image": "assets/images/9.jpeg", "page": const SpellingGameScreen(), "color": Colors.deepOrange},
  ];

  final List<Map<String, dynamic>> mathItems = [
    {"title": "الأرقام", "image": "assets/images/5.jpeg", "page": const NumbersScreen(), "color": Colors.orange},
    {"title": "اختبار الأرقام", "image": "assets/images/8.jpeg", "page": const NumbersQuizScreen(), "color": Colors.red},
    {"title": "اختر الرقم الصحيح", "image": "assets/images/7.jpeg", "page": const ChooseNumberGame(), "color": Colors.blue},
    {"title": "أشكال وأرقام", "image": "assets/images/10.jpeg", "page": const ShapesGameNumber(), "color": Colors.teal},
  ];

  List<Map<String, dynamic>> get currentItems =>
      selectedIndex == 0 ? arabicItems : mathItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF81C784),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),

              const Text(
                "المستوى الأول ( الروضة )",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton("اللغة العربية", 0, Icons.menu_book),
                  const SizedBox(width: 12),
                  buildButton("رياضيات", 1, Icons.calculate),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    itemCount: currentItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) =>
                        buildCard(context, currentItems[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item["page"]),
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
            Container(
              width: 85,
              height: 85,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    item["image"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, int index, IconData icon) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20,
                color: isSelected ? Colors.black : Colors.white),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}