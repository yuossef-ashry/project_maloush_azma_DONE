import 'package:flutter/material.dart';

import 'level_two_games/arabic_games_2/spelling_game_screen.dart';
import 'level_two_games/arabic_games_2/choose_answer_screen.dart';
import 'level_two_games/arabic_games_2/months_screen.dart';
import 'level_two_games/arabic_games_2/drag_drop_screen.dart';
import 'level_two_games/arabic_games_2/quran_screen.dart';
import 'level_two_games/arabic_games_2/quran_quiz_screen.dart';

class LevelTwoArabicScreen extends StatelessWidget {
  LevelTwoArabicScreen({super.key});

  final List<Map<String, dynamic>> items = [
    {
      "title": "الاملاء",
      "image": "assets/images/7.jpeg",
      "page": const SpellingGameScreen(),
      "color": Colors.orange,
    },

    {
      "title": "اختر الاجابة الصحيحة",
      "image": "assets/images/9.jpeg",
      "page": const ChooseAnswerScreen(),
      "color": Colors.purple,
    },
    {
      "title": "السحب والافلات",
      "image": "assets/images/10.jpeg",
      "page": const DragDropScreen(),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                  "المستوى الثاني - عربي",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
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
                      return buildCard(context, items[index]);
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

            /// 🟢 الصورة الدائرية
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
}