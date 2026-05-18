import 'dart:math';
import 'package:flutter/material.dart';

import 'game_background.dart';
import 'game_header.dart';
import 'game_progress_bar.dart';
<<<<<<< HEAD
import 'game_card_number.dart';          // 👈 استبدلنا game_card.dart بـ game_card_number.dart
=======
import 'game_card.dart';
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
import 'game_result_screen.dart';
import 'game_option_button.dart';
import 'app_colors.dart';

class QuizGameEngine extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;
  final List<String> optionsPool;

  const QuizGameEngine({
    super.key,
    required this.title,
    required this.questions,
    required this.optionsPool,
  });

  @override
  State<QuizGameEngine> createState() => _QuizGameEngineState();
}

class _QuizGameEngineState extends State<QuizGameEngine> {
  int index = 0;
  int score = 0;

  List<String> options = [];
  String? selected;
  bool answered = false;
  bool showResult = false;

  Map<String, dynamic> get current => widget.questions[index];

  String get question => current["question"] ?? "";
  String get answer => current["answer"] ?? "";
  String? get image => current["image"];

  List<String> get pool =>
      current["options"] != null
          ? List<String>.from(current["options"])
          : widget.optionsPool;

  @override
  void initState() {
    super.initState();
    _generateOptions();
  }

  void _generateOptions() {
    final rand = Random();
    Set<String> set = {answer};

    while (set.length < 4) {
      set.add(pool[rand.nextInt(pool.length)]);
    }

    options = set.toList()..shuffle();
  }

  void check(String value) {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;
      if (value == answer) score++;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      if (index == widget.questions.length - 1) {
        setState(() => showResult = true);
      } else {
        setState(() {
          index++;
          selected = null;
          answered = false;
          _generateOptions();
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
      _generateOptions();
    });
  }

  Color getColor(String v) {
    if (!answered) return AppColors.orange;
    if (v == answer) return AppColors.green;
    if (v == selected) return AppColors.red;
    return AppColors.grey;
  }

  String getText(String v) {
    if (!answered) return v;
    if (v == answer) return "$v ✔️";
    if (v == selected) return "$v ❌";
    return v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: showResult
              ? GameResultScreen(
            score: score,
            total: widget.questions.length,
            onRestart: restart,
          )
              : Column(
            children: [
              const SizedBox(height: 10),
<<<<<<< HEAD
=======

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
              GameHeader(
                title: widget.title,
                score: score,
              ),
<<<<<<< HEAD
              const SizedBox(height: 10),
=======

              const SizedBox(height: 10),

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
              GameProgressBar(
                current: index,
                total: widget.questions.length,
              ),
<<<<<<< HEAD
              const SizedBox(height: 20), // قللنا المسافة من 60 إلى 20 لتلائم الكارد

              // ✅ استخدام GameCardNumber بدلاً من GameCard
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GameCardNumber(   // 👈 هنا التغيير الأساسي
=======

              const SizedBox(height: 20),

              // ✅ CARD FIXED (no overflow)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GameCard(
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (image != null)
                        Text(
                          image!,
<<<<<<< HEAD
                          style: const TextStyle(fontSize: 80),
                        ),
                      const SizedBox(height: 20),
=======
                          style: const TextStyle(fontSize: 70),
                        ),

                      const SizedBox(height: 10),

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
                      Text(
                        question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
<<<<<<< HEAD
                          fontSize: 30, // قللنا الخط قليلاً ليلائم المساحة
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "اختار الإجابة الصحيحة",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
=======
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "اختار الإجابة الصحيحة",
                        style: TextStyle(fontSize: 16),
                      ),
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

<<<<<<< HEAD
=======
              // ✅ GRID FIXED PROPERLY
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    physics: const BouncingScrollPhysics(),
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
<<<<<<< HEAD
=======

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
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