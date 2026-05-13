import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_colors.dart';

class MatchImageNumberScreen extends StatefulWidget {
  const MatchImageNumberScreen({super.key});

  @override
  State<MatchImageNumberScreen> createState() =>
      _MatchImageNumberScreenState();
}

class _MatchImageNumberScreenState extends State<MatchImageNumberScreen> {
  final List<Map<String, dynamic>> questions = [
    {"emoji": "🍎", "count": 1},
    {"emoji": "🍌", "count": 2},
    {"emoji": "🍓", "count": 3},
    {"emoji": "⚽", "count": 4},
    {"emoji": "⭐", "count": 1},
    {"emoji": "🚗", "count": 2},
    {"emoji": "🐥", "count": 3},
    {"emoji": "🌸", "count": 4},
    {"emoji": "🍇", "count": 2},
    {"emoji": "🦋", "count": 3},
  ];

  final options = [1, 2, 3, 4];

  int index = 0;
  int score = 0;
  int selected = -1;
  bool showResult = false;

  Map<String, dynamic> get current => questions[index];
  int get correct => current["count"];
  String get emoji => current["emoji"];

  // ───────── RESET ─────────
  void reset() {
    setState(() {
      index = 0;
      score = 0;
      selected = -1;
      showResult = false;
    });
  }

  // ───────── ANSWER ─────────
  void answer(int value) async {
    if (selected != -1) return;

    setState(() => selected = value);

    if (value == correct) score++;

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    if (index == questions.length - 1) {
      setState(() => showResult = true);
    } else {
      setState(() {
        index++;
        selected = -1;
      });
    }
  }

  // ───────── COLORS ─────────
  Color getColor(int opt) {
    if (selected == -1) return GameColors.option;

    if (opt == correct) return GameColors.correct;
    if (opt == selected) return GameColors.wrong;

    return GameColors.disabled;
  }

  // ───────── TEXT WITH FEEDBACK ─────────
  String getText(int opt) {
    if (selected == -1) return "$opt";

    if (opt == correct) return "$opt ✔️";
    if (opt == selected) return "$opt ❌";

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
            total: questions.length,
            onRestart: reset,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "صل الصور بالرقم 🔢",
                score: score,
              ),

              const SizedBox(height: 15),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 30),

              // ───────── QUESTION ─────────
              GameCard(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        correct,
                            (_) => const Text(
                          "🍎",
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    if (selected != -1)
                      Icon(
                        selected == correct
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: selected == correct
                            ? GameColors.correct
                            : GameColors.wrong,
                        size: 50,
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ───────── OPTIONS ─────────
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
                      onTap: () => answer(opt),
                      disabled: selected != -1,
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