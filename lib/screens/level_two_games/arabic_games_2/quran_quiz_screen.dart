import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';

class QuranQuizScreen extends StatefulWidget {
  const QuranQuizScreen({super.key});

  @override
  State<QuranQuizScreen> createState() => _QuranQuizScreenState();
}

class _QuranQuizScreenState extends State<QuranQuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "كم عدد آيات سورة الفاتحة؟",
      "options": ["5", "6", "7", "8"],
      "correctOption": "7",
    },
    {
      "question": "ما هي السورة التي تُسمى (أم القرآن)؟",
      "options": ["الإخلاص", "الفاتحة", "الكوثر", "الناس"],
      "correctOption": "الفاتحة",
    },
    {
      "question": "كم عدد آيات سورة الإخلاص؟",
      "options": ["3", "4", "5", "6"],
      "correctOption": "4",
    },
    {
      "question": "ما هي أقصر سورة في القرآن؟",
      "options": ["الفاتحة", "الإخلاص", "الكوثر", "الناس"],
      "correctOption": "الكوثر",
    },
    {
      "question": "ما هي آخر سورة في القرآن؟",
      "options": ["الفلق", "الكوثر", "الإخلاص", "الناس"],
      "correctOption": "الناس",
    },
  ];

  int index = 0;
  int score = 0;

  String? selected;
  bool answered = false;
  bool showResult = false;

  Map<String, dynamic> get q => questions[index];
  List<String> get options => List<String>.from(q["options"]);
  String get correct => q["correctOption"];

  void check(String value) {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;

      if (value == correct) {
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
                title: "اختبار القرآن",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 20),

              GameCard(
                child: Text(
                  q["question"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, i) {
                      final opt = options[i];

                      Color color = Colors.orange;

                      if (answered) {
                        if (opt == correct) {
                          color = Colors.green;
                        } else if (opt == selected) {
                          color = Colors.red;
                        } else {
                          color = Colors.grey;
                        }
                      }

                      return GameOptionButton(
                        text: answered
                            ? (opt == correct
                            ? "$opt ✔️"
                            : opt == selected
                            ? "$opt ❌"
                            : opt)
                            : opt,
                        color: color,
                        disabled: answered,
                        onTap: () => check(opt),
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