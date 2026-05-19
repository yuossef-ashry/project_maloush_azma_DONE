import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'game_background.dart';
import 'game_header.dart';
import 'game_progress_bar.dart';
import 'game_card_quiz.dart';
import 'game_option_button.dart';
import 'game_result_screen.dart';
import 'app_colors.dart';

class QuizGameScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;
  final List<String> optionsPool;
  final bool showEmoji;

  const QuizGameScreen({
    super.key,
    required this.title,
    required this.questions,
    required this.optionsPool,
    this.showEmoji = false,
  });

  @override
  State<QuizGameScreen> createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen> {
  final AudioPlayer player = AudioPlayer();

  int index = 0;
  int score = 0;

  List<String> options = [];
  String selected = "";
  bool answered = false;
  bool showResult = false;

  Map<String, dynamic> get current => widget.questions[index];

  String get correct => current["answer"] ?? current["number"];
  String get sound => current["sound"];
  String? get emoji => current["emoji"];

  @override
  void initState() {
    super.initState();
    generateOptions();
    playSound();
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  // ───────── تشغيل الصوت ─────────
  Future<void> playSound() async {
    try {
      await player.stop();
      await player.play(AssetSource("sounds/$sound"));
    } catch (e) {
      debugPrint("Sound error: $e");
    }
  }

  // ───────── توليد الخيارات ─────────
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correct};

    while (set.length < 4) {
      set.add(widget.optionsPool[rand.nextInt(widget.optionsPool.length)]);
    }

    options = set.toList()..shuffle();
  }

  // ───────── الإجابة ─────────
  void answer(String value) async {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;
      if (value == correct) score++;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    if (index == widget.questions.length - 1) {
      setState(() => showResult = true);
    } else {
      setState(() {
        index++;
        selected = "";
        answered = false;
        generateOptions();
      });
      playSound();
    }
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      selected = "";
      answered = false;
      showResult = false;
      generateOptions();
    });
    playSound();
  }

  // ───────── ألوان الخيارات ─────────
  Color getColor(String v) {
    if (!answered) return AppColors.orange;
    if (v == correct) return AppColors.green;
    if (v == selected) return AppColors.red;
    return AppColors.grey;
  }

  String getText(String v) {
    if (!answered) return v;
    if (v == correct) return "$v ✔️";
    if (v == selected) return "$v ❌";
    return v;
  }

  // ───────── بناء الواجهة ─────────
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
              const SizedBox(height: 5),

              GameHeader(
                title: widget.title,
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: widget.questions.length,
              ),

              const SizedBox(height: 30),

              // البطاقة الأساسية (السؤال والصوت والإيموجي)
              GameCardQuiz(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showEmoji && emoji != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          emoji!,
                          style: const TextStyle(fontSize: 80),
                        ),
                      ),
                    const SizedBox(height: 20),

                    IconButton(
                      onPressed: playSound,
                      icon: const Icon(
                        Icons.volume_up,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "استمع واختر الإجابة الصحيحة",
                      style: TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // شبكة الخيارات
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
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, i) {
                      final v = options[i];
                      return GameOptionButton(
                        text: getText(v),
                        color: getColor(v),
                        onTap: () => answer(v),
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