import 'package:flutter/material.dart';
import 'dart:math';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_colors.dart';

abstract class BaseMathGameScreen extends StatefulWidget {
  const BaseMathGameScreen({super.key});

  String get title;
  int get totalQuestions => 10;

  @override
  BaseMathGameState createState();
}

abstract class BaseMathGameState<T extends BaseMathGameScreen>
    extends State<T> {
  final Random random = Random();

  int num1 = 0;
  int num2 = 0;

  List<int> options = [];
  int? selectedAnswer;

  int score = 0;
  int questionNumber = 0;

  bool answered = false;
  bool showResult = false;

  int get correctAnswer;

  void generateNumbers();

  void generateQuestion() {
    generateNumbers();

    selectedAnswer = null;
    answered = false;

    Set<int> set = {correctAnswer};

    while (set.length < 4) {
      set.add(random.nextInt(20) + 1);
    }

    options = set.toList()..shuffle();

    setState(() {});
  }

  void reset() {
    setState(() {
      score = 0;
      questionNumber = 0;
      showResult = false;
      generateQuestion();
    });
  }

  void checkAnswer(int answer) async {
    if (answered) return;

    setState(() {
      selectedAnswer = answer;
      answered = true;

      if (answer == correctAnswer) {
        score++;
      }
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    if (questionNumber == widget.totalQuestions - 1) {
      setState(() => showResult = true);
    } else {
      setState(() {
        questionNumber++;
        generateQuestion();
      });
    }
  }

  Color getColor(int opt) {
    if (!answered) return GameColors.option;
    if (opt == correctAnswer) return GameColors.correct;
    if (opt == selectedAnswer) return GameColors.wrong;
    return GameColors.disabled;
  }

  String getText(int opt) {
    if (!answered) return "$opt";
    if (opt == correctAnswer) return "$opt ✔️";
    if (opt == selectedAnswer) return "$opt ❌";
    return "$opt";
  }

  Widget buildQuestion(BuildContext context);

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: showResult
              ? GameResultScreen(
            score: score,
            total: widget.totalQuestions,
            onRestart: reset,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: widget.title,
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: questionNumber,
                total: widget.totalQuestions,
              ),

              const SizedBox(height: 20),

              GameCard(child: buildQuestion(context)),

              const SizedBox(height: 20),

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