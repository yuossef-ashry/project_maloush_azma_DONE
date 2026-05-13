import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_colors.dart';

class ChooseNumberScreen extends StatefulWidget {
  const ChooseNumberScreen({super.key});

  @override
  State<ChooseNumberScreen> createState() => _ChooseNumberScreenState();
}

class _ChooseNumberScreenState extends State<ChooseNumberScreen> {
  final List<Map<String, String>> questions = [
    {"word": "واحد", "number": "1"},
    {"word": "اثنين", "number": "2"},
    {"word": "ثلاثة", "number": "3"},
    {"word": "أربعة", "number": "4"},
    {"word": "خمسة", "number": "5"},
    {"word": "ستة", "number": "6"},
    {"word": "سبعة", "number": "7"},
    {"word": "ثمانية", "number": "8"},
    {"word": "تسعة", "number": "9"},
    {"word": "عشرة", "number": "10"},
  ];

  final numbers = ["1","2","3","4","5","6","7","8","9","10"];

  int index = 0;
  int score = 0;

  List<String> options = [];
  String? selected;
  bool answered = false;
  bool showResult = false;

  String get word => questions[index]["word"]!;
  String get correct => questions[index]["number"]!;

  @override
  void initState() {
    super.initState();
    generateOptions();
  }

  // ───────── OPTIONS ─────────
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correct};

    while (set.length < 4) {
      set.add(numbers[rand.nextInt(numbers.length)]);
    }

    options = set.toList()..shuffle();
  }

  // ───────── RESET ─────────
  void reset() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
      answered = false;
      showResult = false;
      generateOptions();
    });
  }

  // ───────── ANSWER ─────────
  void check(String value) async {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;

      if (value == correct) score++;
    });

    await Future.delayed(const Duration(milliseconds: 600));

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
  }

  // ───────── COLORS ─────────
  Color getColor(String v) {
    if (!answered) return GameColors.option;

    if (v == correct) return GameColors.correct;
    if (v == selected) return GameColors.wrong;

    return GameColors.disabled;
  }

  // ───────── TEXT FEEDBACK ─────────
  String getText(String v) {
    if (!answered) return v;

    if (v == correct) return "$v ✔️";
    if (v == selected) return "$v ❌";

    return v;
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
            onRestart: reset,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "اختبار الأرقام 🔢",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 30),

              // QUESTION
              GameCard(
                child: Text(
                  word,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // OPTIONS
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: options.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, i) {
                    final v = options[i];

                    return GameOptionButton(
                      text: getText(v),
                      color: getColor(v),
                      onTap: () => check(v),
                      disabled: answered,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}