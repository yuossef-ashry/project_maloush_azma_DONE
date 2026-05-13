import 'dart:math';
import 'package:flutter/material.dart';
import 'game_result_screen.dart';

class ChooseLetterGame extends StatefulWidget {
  const ChooseLetterGame({super.key});

  @override
  State<ChooseLetterGame> createState() => _ChooseLetterGameState();
}

class _ChooseLetterGameState extends State<ChooseLetterGame> {
  final List<Map<String, String>> questions = [
    {"word": "أسد", "letter": "أ"},
    {"word": "بطة", "letter": "ب"},
    {"word": "تفاح", "letter": "ت"},
    {"word": "ثعلب", "letter": "ث"},
    {"word": "جمل", "letter": "ج"},
    {"word": "حوت", "letter": "ح"},
    {"word": "خبز", "letter": "خ"},
    {"word": "دب", "letter": "د"},
    {"word": "ذرة", "letter": "ذ"},
    {"word": "رمان", "letter": "ر"},
  ];

  final List<String> letters = [
    "أ",
    "ب",
    "ت",
    "ث",
    "ج",
    "ح",
    "خ",
    "د",
    "ذ",
    "ر",
    "ز",
    "س",
    "ش",
    "ص",
    "ض"
  ];

  int index = 0;
  int score = 0;

  List<String> options = [];
  String? selected;
  bool answered = false;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    generateOptions();
  }

  String get word => questions[index]["word"]!;
  String get correct => questions[index]["letter"]!;

  void generateOptions() {
    final rand = Random();

    Set<String> set = {correct};

    while (set.length < 4) {
      set.add(letters[rand.nextInt(letters.length)]);
    }

    options = set.toList()..shuffle();
  }

  void check(String value) {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;

      if (value == correct) {
        score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      if (index == questions.length - 1) {
        setState(() {
          showResult = true;
        });
      } else {
        setState(() {
          index++;
          selected = null;
          answered = false;
          generateOptions();
        });
      }
    });
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
      answered = false;
      showResult = false;
      generateOptions();
    });
  }

  Color buttonColor(String value) {
    if (!answered) return Colors.orange;

    if (value == correct) {
      return Colors.green;
    }

    if (value == selected) {
      return Colors.red;
    }

    return Colors.grey;
  }

  Widget buildBackground({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBackground(
        child: showResult
            ? GameResultScreen(
          score: score,
          total: questions.length,
          onRestart: restart,
        )
            : buildGame(),
      ),
    );
  }

  Widget buildGame() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),

                const Text(
                  "اختبار الحروف",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "$score",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: List.generate(
                questions.length,
                    (i) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                        i <= index ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text(
                  word,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "يبدأ بأي حرف؟",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Column(
            children: options.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: 260,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor(e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => check(e),
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}