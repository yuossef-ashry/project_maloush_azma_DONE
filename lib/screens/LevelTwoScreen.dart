import 'package:flutter/material.dart';

// Arabic games

import 'level_two_games/arabic_games_2/months_screen.dart';
import 'level_two_games/arabic_games_2/drag_drop_screen.dart';
import 'level_two_games/arabic_games_2/quran_screen.dart';
import 'level_two_games/arabic_games_2/quran_quiz_screen.dart';

// Math games
import 'level_two_games/math_games_2/addition_game_screen.dart';
import 'level_two_games/math_games_2/subtraction_game_screen.dart';
import 'level_two_games/math_games_2/multiplication_game_screen.dart';
import 'level_two_games/math_games_2/division_game_screen.dart';

class LevelTwoScreen extends StatefulWidget {
  const LevelTwoScreen({super.key});

  @override
  State<LevelTwoScreen> createState() => _LevelTwoScreenState();
}

class _LevelTwoScreenState extends State<LevelTwoScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> arabicItems = [
    {
      "title": "السحب والإفلات",
      "image": "assets/images/10.jpeg",
      "page": const EmojiDragDropGame(),
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
  ];

  final List<Map<String, dynamic>> mathItems = [
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
                "المستوى الثاني - المدرسة",
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
          boxShadow: isSelected
              ? const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]
              : [],
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