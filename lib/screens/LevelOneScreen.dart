import 'package:flutter/material.dart';

import '../screens/level_one_games/Arabic_games/letters_game.dart';
import '../screens/level_one_games/Arabic_games/letters_quiz_game.dart';
import '../screens/level_one_games/Arabic_games/choose_letter_game.dart';
import '../screens/level_one_games/Arabic_games/shapes_game.dart';

import '../screens/level_one_games/math_games/numbers_screen.dart';
import '../screens/level_one_games/math_games/match_image_number_screen.dart';
import '../screens/level_one_games/math_games/choose_number_screen.dart';
import '../screens/level_one_games/math_games/numbers_quiz_screen.dart';

class LevelOneScreen extends StatefulWidget {
  const LevelOneScreen({super.key});

  @override
  State<LevelOneScreen> createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  int selectedIndex = 0;

  /// 🟠 العربي
  final List<Map<String, dynamic>> arabicItems = [
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
      "title": "اختر الحرف الصحيح",
      "image": "assets/images/3.jpeg",
      "page": ChooseLetterGame(),
      "color": Colors.purple,
    },
    {
      "title": "توصيل الأشكال",
      "image": "assets/images/4.jpeg",
      "page": ShapesGame(),
      "color": Colors.green,
    },
  ];

  /// 🔵 الرياضيات
  final List<Map<String, dynamic>> mathItems = [
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
    },  {
      "title": "صل الصورة بالرقم",
      "image": "assets/images/6.jpeg",
      "page": MatchImageNumberScreen(),
      "color": Colors.purple,
    } ,

  ];

  @override
  Widget build(BuildContext context) {
    final currentItems =
    selectedIndex == 0 ? arabicItems : mathItems;

    return Scaffold(
      backgroundColor: const Color(0xFF4FC3F7),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            /// 🏆 العنوان
            const Text(
              "المستوى الأول ( الروضة )",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 25),

            /// 🎯 أزرار التبديل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(
                  "اللغة العربية",
                  0,
                  Icons.menu_book,
                ),

                const SizedBox(width: 12),

                buildButton(
                  "رياضيات",
                  1,
                  Icons.calculate,
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 📦 الجريد
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  itemCount: currentItems.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.85,
                  ),

                  itemBuilder: (context, index) {
                    return buildCard(
                      context,
                      currentItems[index],
                    );
                  },
                ),
              ),
            ),
          ],
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
            builder: (_) => item["page"],
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
            /// 🟢 الصورة
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

            /// 📝 العنوان
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

  /// 🔘 زرار التبديل
  Widget buildButton(
      String text,
      int index,
      IconData icon,
      ) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withOpacity(0.25),

          borderRadius: BorderRadius.circular(25),

          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
              : [],
        ),

        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color:
              isSelected ? Colors.black : Colors.white,
            ),

            const SizedBox(width: 6),

            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? Colors.black
                    : Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}