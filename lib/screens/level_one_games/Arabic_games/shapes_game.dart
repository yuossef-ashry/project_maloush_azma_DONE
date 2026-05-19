import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card_shapes.dart';

import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_colors.dart';

class ShapesGame extends StatefulWidget {
  const ShapesGame({super.key});

  @override
  State<ShapesGame> createState() => _ShapesGameState();
}

class _ShapesGameState extends State<ShapesGame> {
  final List<Map<String, dynamic>> questions = [
    {"image": "assets/images/dog.png", "name": "كلب"},
    {"image": "assets/images/cat.png", "name": "قطة"},
    {"image": "assets/images/lion.png", "name": "أسد"},
    {"image": "assets/images/horse.jpg", "name": "حصان"},

    {"image": "assets/images/elephant.jpg", "name": "فيل"},
    {"image": "assets/images/horse.jpg", "name": "حصان"},
    {"image": "assets/images/bird.jpg", "name": "طائر"},
  ];

  final List<String> words = ["كلب", "قطة", "أسد", "حصان", ];

  int index = 0;
  int score = 0;

  String? droppedWord;
  bool showFeedback = false;
  bool showResult = false;
  bool isCorrect = false;

  List<String> options = [];

  @override
  void initState() {
    super.initState();
    generateOptions();
  }

  String get image => questions[index]["image"];
  String get correct => questions[index]["name"];

  // ───────── OPTIONS ─────────
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correct};

    while (set.length < 3) {
      set.add(words[rand.nextInt(words.length)]);
    }

    options = set.toList()..shuffle();
  }

  // ───────── ANSWER ─────────
  void checkAnswer(String value) {
    if (showFeedback) return;

    setState(() {
      droppedWord = value;
      showFeedback = true;
      isCorrect = value == correct;

      if (isCorrect) score++;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      if (index == questions.length - 1) {
        setState(() => showResult = true);
      } else {
        setState(() {
          index++;
          droppedWord = null;
          showFeedback = false;
          isCorrect = false;
          generateOptions();
        });
      }
    });
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      droppedWord = null;
      showFeedback = false;
      showResult = false;
      isCorrect = false;
      generateOptions();
    });
  }

  // ───────── COLORS ─────────
  Color getWordColor() {
    if (!showFeedback) return GameColors.option;
    return isCorrect ? GameColors.correct : GameColors.wrong;
  }

  IconData getIcon() {
    if (!showFeedback) return Icons.help_outline;
    return isCorrect ? Icons.check_circle : Icons.cancel;
  }

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: showResult ? _result() : _game(),
        ),
      ),
    );
  }

  // ───────── RESULT ─────────
  Widget _result() {
    return GameResultScreen(
      score: score,
      total: questions.length,
      onRestart: restart,
    );
  }

  // ───────── GAME ─────────
  Widget _game() {
    return Column(
      children: [
        const SizedBox(height: 10),

        GameHeader(
          title: "وصل الصورة بالكلمة 🧩",
          score: score,
        ),

        const SizedBox(height: 10),

        GameProgressBar(
          current: index,
          total: questions.length,
        ),

        const SizedBox(height: 20),

        // IMAGE
        GameCardShapes(
          child: Image.asset(image, height: 150),
        ),

        const SizedBox(height: 15),

        // DROP AREA
        GameCardShapes(
          child: DragTarget<String>(
            onAccept: checkAnswer,
            builder: (context, _, __) {
              return SizedBox(
                height: 120,
                child: Center(
                  child: droppedWord == null
                      ? const Text(
                    "⬇️ اسحب الكلمة هنا",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        droppedWord!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: getWordColor(),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Icon(
                        getIcon(),
                        color: getWordColor(),
                        size: 32,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 15),

        // OPTIONS
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, i) {
                final word = options[i];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),

                  child: Draggable<String>(
                    data: word,

                    feedback: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 200,
                        child: _wordCard(word),
                      ),
                    ),

                    childWhenDragging: Opacity(
                      opacity: 0.4,
                      child: _wordCard(word),
                    ),

                    child: _wordCard(word),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ───────── WORD CARD ─────────
  Widget _wordCard(String text) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GameColors.option,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}