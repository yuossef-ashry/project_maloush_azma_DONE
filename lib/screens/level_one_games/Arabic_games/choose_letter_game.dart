import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/app_colors.dart';

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
    "أ","ب","ت","ث","ج","ح","خ","د","ذ","ر",
    "ز","س","ش","ص","ض"
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

  // ───────── OPTIONS ─────────
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correct};

    while (set.length < 4) {
      set.add(letters[rand.nextInt(letters.length)]);
    }

    options = set.toList()..shuffle();
  }

  // ───────── CHECK ─────────
  void check(String value) {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;

      if (value == correct) score++;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      if (index == questions.length - 1) {
        setState(() => showResult = true);
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

  // ───────── COLORS ─────────
  Color getColor(String value) {
    if (!answered) return AppColors.orange;

    if (value == correct) return AppColors.green;
    if (value == selected) return AppColors.red;

    return AppColors.grey;
  }

  // ───────── TEXT WITH FEEDBACK ─────────
  String getText(String opt) {
    if (!answered) return opt;

    if (opt == correct) return "$opt ✔️";
    if (opt == selected) return "$opt ❌";

    return opt;
  }

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: showResult
              ? GameResultScreen(
            score: score,
            total: questions.length,
            onRestart: restart,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "اختبار الحروف",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 25),

              // ───────── QUESTION ─────────
              GameCard(
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ───────── OPTIONS ─────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, i) {
                      final opt = options[i];

                      return GameOptionButton(
                        text: getText(opt),
                        color: getColor(opt),
                        onTap: () => check(opt),
                        disabled: answered,
                      );
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
}