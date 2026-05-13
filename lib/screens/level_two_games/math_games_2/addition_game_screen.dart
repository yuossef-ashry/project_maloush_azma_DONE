import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_colors.dart';

class AdditionGameScreen extends StatefulWidget {
  const AdditionGameScreen({super.key});

  @override
  State<AdditionGameScreen> createState() => _AdditionGameScreenState();
}

class _AdditionGameScreenState extends State<AdditionGameScreen> {
  final Random _random = Random();

  final List<String> shapes = ['🍎', '🌟', '🎈', '🍭', '🌸'];

  int num1 = 0;
  int num2 = 0;
  String currentShape = '🍎';

  List<int> options = [];
  int? selectedAnswer;

  int score = 0;
  int questionNumber = 0;

  bool answered = false;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  // ───────── GENERATE QUESTION ─────────
  void generateQuestion() {
    num1 = _random.nextInt(5) + 1;
    num2 = _random.nextInt(5) + 1;

    currentShape = shapes[_random.nextInt(shapes.length)];

    selectedAnswer = null;
    answered = false;

    int correct = num1 + num2;

    Set<int> set = {correct};
    while (set.length < 4) {
      set.add(_random.nextInt(10) + 1);
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

      if (answer == num1 + num2) {
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

    if (opt == num1 + num2) return GameColors.correct;
    if (opt == selectedAnswer) return GameColors.wrong;

    return GameColors.disabled;
  }

  String getText(int opt) {
    if (!answered) return "$opt";

    if (opt == num1 + num2) return "$opt ✔️";
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

              // HEADER
              GameHeader(
                title: "لعبة الجمع ➕",
                score: score,
              ),

              const SizedBox(height: 10),

              // PROGRESS
              GameProgressBar(
                current: questionNumber,
                total: 10,
              ),

              const SizedBox(height: 25),

              // QUESTION CARD
              GameCard(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        num1,
                            (_) => Text(
                          currentShape,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),

                    const Text("+", style: TextStyle(fontSize: 28)),

                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        num2,
                            (_) => Text(
                          currentShape,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),

                    const Text("= ?", style: TextStyle(fontSize: 28)),
                  ],
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