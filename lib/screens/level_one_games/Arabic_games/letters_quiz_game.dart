import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/app_colors.dart';

class LettersQuizGame extends StatefulWidget {
  const LettersQuizGame({super.key});

  @override
  State<LettersQuizGame> createState() => _LettersQuizGameState();
}

class _LettersQuizGameState extends State<LettersQuizGame> {
  final AudioPlayer player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {"emoji": "🦁", "answer": "أ", "sound": "1.mp3"},
    {"emoji": "🍎", "answer": "ت", "sound": "2.mp3"},
    {"emoji": "🐘", "answer": "ف", "sound": "3.mp3"},
    {"emoji": "🌹", "answer": "و", "sound": "4.mp3"},
    {"emoji": "🐟", "answer": "س", "sound": "5.mp3"},
    {"emoji": "🌸", "answer": "ز", "sound": "6.mp3"},
    {"emoji": "☀️", "answer": "ش", "sound": "7.mp3"},
    {"emoji": "🦊", "answer": "ث", "sound": "8.mp3"},
  ];

  final List<String> letters = [
    "أ","ب","ت","ث","ج","ح","خ","د","ذ","ر","ز","س",
    "ش","ص","ض","ط","ظ","ع","غ","ف","ق","ك","ل","م",
    "ن","ه","و","ي"
  ];

  int index = 0;
  int score = 0;

  List<String> options = [];
  String selected = "";
  bool answered = false;
  bool showResult = false;

  String get correct => questions[index]["answer"];
  String get emoji => questions[index]["emoji"];
  String get sound => questions[index]["sound"];

  @override
  void initState() {
    super.initState();
    generateOptions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      playSound();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  // ───────── SOUND ─────────
  Future<void> playSound() async {
    try {
      await player.stop();
      await player.play(AssetSource("sounds/$sound"));
    } catch (e) {
      debugPrint("Sound Error: $e");
    }
  }

  // ───────── OPTIONS ─────────
  void generateOptions() {
    final rand = Random();
    Set<String> set = {correct};

    while (set.length < 4) {
      set.add(letters[rand.nextInt(letters.length)]);
    }

    options = set.toList()..shuffle();
  }

  // ───────── ANSWER ─────────
  Future<void> answer(String value) async {
    if (answered) return;

    setState(() {
      selected = value;
      answered = true;

      if (value == correct) score++;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    if (index == questions.length - 1) {
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

  // ───────── COLORS ─────────
  Color getColor(String value) {
    if (!answered) return AppColors.orange;

    if (value == correct) return AppColors.green;
    if (value == selected) return AppColors.red;

    return AppColors.grey;
  }

  // ───────── TEXT WITH FEEDBACK ─────────
  String getText(String opt) {
    if (!answered) return opt;

    if (opt == correct) return "$opt ✔️";
    if (opt == selected) return "$opt ❌";

    return opt;
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
            onRestart: restart,
          )
              : Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "اختبار الحروف 🎧",
                score: score,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: questions.length,
              ),

              const SizedBox(height: 25),

              // ───────── QUESTION ─────────
              GameCard(
                child: Column(
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 10),

                    IconButton(
                      onPressed: playSound,
                      icon: const Icon(
                        Icons.volume_up,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),

                    const Text(
                      "استمع واختر الحرف الصحيح",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ───────── OPTIONS ─────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, i) {
                      final opt = options[i];

                      return GameOptionButton(
                        text: getText(opt),
                        color: getColor(opt),
                        onTap: () => answer(opt),
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