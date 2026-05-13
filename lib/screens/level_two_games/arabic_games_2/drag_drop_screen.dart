import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🐱",
      "correctWord": "قطة",
      "options": ["قطة", "كلب", "بطة"],
    },
    {
      "image": "🐶",
      "correctWord": "كلب",
      "options": ["قطة", "كلب", "فيل"],
    },
    {
      "image": "🐘",
      "correctWord": "فيل",
      "options": ["أسد", "جمل", "فيل"],
    },
    {
      "image": "🦁",
      "correctWord": "أسد",
      "options": ["أسد", "قرد", "بطة"],
    },
    {
      "image": "🐪",
      "correctWord": "جمل",
      "options": ["فيل", "جمل", "ذئب"],
    },
  ];

  int currentIndex = 0;
  int score = 0;

  String? droppedWord;
  bool? isCorrect;

  bool showResult = false;

  Map<String, dynamic> get q => questions[currentIndex];

  // ───────── RESET ─────────
  void reset() {
    setState(() {
      currentIndex = 0;
      score = 0;
      droppedWord = null;
      isCorrect = null;
      showResult = false;
    });
  }

  // ───────── NEXT QUESTION ─────────
  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        droppedWord = null;
        isCorrect = null;
      });
    } else {
      setState(() {
        showResult = true;
      });
    }
  }

  // ───────── COLORS ─────────
  Color getDropColor() {
    if (droppedWord == null) return Colors.grey.shade100;

    return isCorrect == true
        ? Colors.green.shade100
        : Colors.red.shade100;
  }

  Color getBorderColor() {
    if (droppedWord == null) return Colors.grey;

    return isCorrect == true
        ? Colors.green
        : Colors.red;
  }

  Color getTextColor() {
    if (droppedWord == null) return Colors.grey;

    return isCorrect == true
        ? Colors.green
        : Colors.red;
  }

  String getDisplayText() {
    if (droppedWord == null) {
      return "اسحب الإجابة هنا";
    }

    return isCorrect == true
        ? "$droppedWord ✔️"
        : "$droppedWord ❌";
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

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
                title: "السحب والإفلات",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: currentIndex,
                total: questions.length,
              ),

              const SizedBox(height: 20),

              // ───────── QUESTION CARD ─────────
              GameCard(
                child: Column(
                  children: [
                    Text(
                      q["image"],
                      style: const TextStyle(fontSize: 90),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "اسحب الكلمة الصحيحة",
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 20),

                    // ───────── DROP AREA ─────────
                    DragTarget<String>(
                      onAcceptWithDetails: (details) {
                        if (droppedWord != null) return;

                        setState(() {
                          droppedWord = details.data;
                          isCorrect =
                              details.data == q["correctWord"];

                          if (isCorrect == true) {
                            score++;
                          }
                        });

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          nextQuestion,
                        );
                      },
                      builder: (
                          context,
                          candidateData,
                          rejectedData,
                          ) {
                        return Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: getDropColor(),
                            borderRadius:
                            BorderRadius.circular(16),
                            border: Border.all(
                              color: getBorderColor(),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getDisplayText(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: getTextColor(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "👇 اسحب الكلمة الصحيحة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 16),

              // ───────── OPTIONS ─────────
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children:
                (q["options"] as List<String>).map((word) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Draggable<String>(
                      data: word,

                      feedback: Material(
                        color: Colors.transparent,
                        child: buildWordBox(word),
                      ),

                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: buildWordBox(word),
                      ),

                      child: buildWordBox(word),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────── WORD BOX ─────────
  Widget buildWordBox(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        word,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}