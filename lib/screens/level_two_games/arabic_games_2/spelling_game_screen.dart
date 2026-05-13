import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/app_colors.dart';

class SpellingGameScreen extends StatefulWidget {
  const SpellingGameScreen({super.key});

  @override
  State<SpellingGameScreen> createState() => _SpellingGameScreenState();
}

class _SpellingGameScreenState extends State<SpellingGameScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🍎",
      "word": "تفاحة",
      "missing": "ا",
      "display": "تف؟حة",
      "options": ["ا", "و", "ي", "ة"],
    },
    {
      "image": "🦁",
      "word": "أسد",
      "missing": "س",
      "display": "أ؟د",
      "options": ["ب", "س", "ك", "ن"],
    },
    {
      "image": "🐘",
      "word": "فيل",
      "missing": "ي",
      "display": "ف؟ل",
      "options": ["ا", "و", "ي", "ة"],
    },
  ];

  int index = 0;
  int score = 0;

  int? selected;
  bool answered = false;
  bool showResult = false;

  Map<String, dynamic> get q => questions[index];
  String get correct => q["missing"];

  // ───────── CHECK ─────────
  void check(int i) {
    if (answered) return;

    setState(() {
      selected = i;
      answered = true;

      if (q["options"][i] == correct) {
        score++;
      }
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
        });
      }
    });
  }

  // ───────── COLORS ─────────
  Color getColor(int i) {
    if (!answered) return AppColors.orange;

    final value = q["options"][i];

    if (value == correct) return AppColors.green;
    if (i == selected) return Colors.red;

    return AppColors.grey;
  }

  // ───────── TEXT (✔ ❌) ─────────
  String getText(int i) {
    if (!answered) return q["options"][i];

    final value = q["options"][i];

    if (value == correct) return "$value ✔️";
    if (i == selected) return "$value ❌";

    return value;
  }

  void reset() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
      answered = false;
      showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: showResult
              ? GameResultScreen(
            score: score,
            total: questions.length,
            onRestart: reset,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "الإملاء",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 20),

              GameCard(
                child: Column(
                  children: [
                    Text(
                      q["image"],
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      q["display"],
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "أكمل الكلمة بالحرف الناقص",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, i) {
                      return GameOptionButton(
                        text: getText(i),
                        color: getColor(i),
                        disabled: answered,
                        onTap: () => check(i),
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