import 'dart:math';
import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card_shapes.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_colors.dart';

class NumbersGame extends StatefulWidget {
  const NumbersGame({super.key});

  @override
  State<NumbersGame> createState() => _NumbersGameState();
}

class _NumbersGameState extends State<NumbersGame> {
  // قائمة الأسئلة: إيموجي والكلمة الصحيحة
  final List<Map<String, String>> questions = [
    {"emoji": "1️⃣", "word": "واحد"},
    {"emoji": "2️⃣", "word": "اثنان"},
    {"emoji": "3️⃣", "word": "ثلاثة"},
    {"emoji": "4️⃣", "word": "أربعة"},
  ];

  // قائمة كل الكلمات المستخدمة للخيارات العشوائية
  final List<String> allWords = [
    "واحد", "اثنان", "ثلاثة", "أربعة", "خمسة",
    "ستة", "سبعة", "ثمانية", "تسعة", "عشرة"
  ];

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

  String get currentEmoji => questions[index]["emoji"]!;
  String get correctWord => questions[index]["word"]!;

  // توليد 3 خيارات: الإجابة الصحيحة + كلمتين عشوائيتين مختلفتين
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correctWord};

    while (set.length < 3) {
      String randomWord = allWords[rand.nextInt(allWords.length)];
      set.add(randomWord);
    }

    options = set.toList()..shuffle();
  }

  void checkAnswer(String value) {
    if (showFeedback) return;

    setState(() {
      droppedWord = value;
      showFeedback = true;
      isCorrect = value == correctWord;

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

  Color getWordColor() {
    if (!showFeedback) return GameColors.option;
    return isCorrect ? GameColors.correct : GameColors.wrong;
  }

  IconData getIcon() {
    if (!showFeedback) return Icons.help_outline;
    return isCorrect ? Icons.check_circle : Icons.cancel;
  }

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

  Widget _result() {
    return GameResultScreen(
      score: score,
      total: questions.length,
      onRestart: restart,
    );
  }

  Widget _game() {
    return Column(
      children: [
        const SizedBox(height: 10),
        GameHeader(
          title: "طابق الإيموجي بالكلمة",
          score: score,
        ),
        const SizedBox(height: 10),
        GameProgressBar(
          current: index,
          total: questions.length,
        ),
        const SizedBox(height: 20),

        // عرض الإيموجي كبير
        GameCardShapes(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              currentEmoji,
              style: const TextStyle(
                fontSize: 80,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 15),

        // منطقة إسقاط الكلمة
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

        // خيارات الكلمات القابلة للسحب
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

  Widget _wordCard(String word) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GameColors.option,
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