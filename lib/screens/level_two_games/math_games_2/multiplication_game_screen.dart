import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_colors.dart';

class MultiplicationGameScreen extends StatefulWidget {
  const MultiplicationGameScreen({super.key});

  @override
  State<MultiplicationGameScreen> createState() =>
      _MultiplicationGameScreenState();
}

class _MultiplicationGameScreenState extends State<MultiplicationGameScreen> {
  final Random _random = Random();

  int num1 = 0;
  int num2 = 0;

  List<int> options = [];
  int? selectedAnswer;

  int score = 0;
  int questionNumber = 0;

  bool answered = false;
  bool showResult = false;

  int get correct => num1 * num2;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  // ───────── GENERATE QUESTION ─────────
  void generateQuestion() {
    num1 = _random.nextInt(5) + 1;
    num2 = _random.nextInt(5) + 1;

    selectedAnswer = null;
    answered = false;

    Set<int> set = {correct};

    while (set.length < 4) {
      set.add(_random.nextInt(25) + 1);
    }

    options = set.toList()..shuffle();

    setState(() {});
  }

  // ───────── RESET ─────────
  void reset() {
    setState(() {
      score = 0;
      questionNumber = 0;
      showResult = false;
      generateQuestion();
    });
  }

  // ───────── CHECK ANSWER ─────────
  void checkAnswer(int answer) async {
    if (answered) return;

    setState(() {
      selectedAnswer = answer;
      answered = true;

      if (answer == correct) {
        score++;
      }
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    if (questionNumber == 9) {
      setState(() => showResult = true);
    } else {
      setState(() {
        questionNumber++;
        generateQuestion();
      });
    }
  }

  // ───────── COLORS ─────────
  Color getColor(int opt) {
    if (!answered) return GameColors.option;

    if (opt == correct) return GameColors.correct;
    if (opt == selectedAnswer) return GameColors.wrong;

    return GameColors.disabled;
  }

  // ───────── TEXT (✔️ ❌) ─────────
  String getText(int opt) {
    if (!answered) return "$opt";

    if (opt == correct) return "$opt ✔️";
    if (opt == selectedAnswer) return "$opt ❌";

    return "$opt";
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
            total: 10,
            onRestart: reset,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "لعبة الضرب ✖",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: questionNumber,
                total: 10,
              ),

              const SizedBox(height: 30),

              // QUESTION
              GameCard(
                child: Text(
                  "$num1 × $num2 = ?",
                  style: const TextStyle(
                    fontSize: 36,
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
                    final opt = options[i];

                    return GameOptionButton(
                      text: getText(opt),
                      color: getColor(opt),
                      disabled: answered,
                      onTap: () => checkAnswer(opt),
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