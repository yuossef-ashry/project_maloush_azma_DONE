import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_result_screen.dart';

class ChooseAnswerScreen extends StatefulWidget {
  const ChooseAnswerScreen({super.key});

  @override
  State<ChooseAnswerScreen> createState() => _ChooseAnswerScreenState();
}

class _ChooseAnswerScreenState extends State<ChooseAnswerScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🌵",
      "question": "أي حيوان يعيش في الصحراء؟",
      "options": ["قرد 🐒", "جمل 🐪", "بطة 🦆", "أرنب 🐰"],
      "correctOption": "جمل 🐪",
    },
    {
      "image": "🍎",
      "question": "ما هو لون التفاحة؟",
      "options": ["أزرق", "أحمر", "أصفر", "أخضر"],
      "correctOption": "أحمر",
    },
    {
      "image": "🌊",
      "question": "ما هو حيوان البحر؟",
      "options": ["سمكة 🐟", "أسد 🦁", "فيل 🐘", "ذئب 🐺"],
      "correctOption": "سمكة 🐟",
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

  Color getColor(String value) {
    if (!answered) return Colors.orange;

    if (value == correct) return Colors.green;
    if (value == selected) return Colors.red;

    return Colors.grey;
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
                title: "اختر الإجابة الصحيحة",
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
                      style: const TextStyle(fontSize: 70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      q["question"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
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

                      return GameOptionButton(
                        text: answered
                            ? (opt == correct
                            ? "$opt ✔️"
                            : opt == selected
                            ? "$opt ❌"
                            : opt)
                            : opt,
                        color: getColor(opt),
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