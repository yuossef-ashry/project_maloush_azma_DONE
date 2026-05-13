import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_result_screen.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/game_colors.dart';
import '../../common/widgets/app_colors.dart';

class NumbersQuizScreen extends StatefulWidget {
  const NumbersQuizScreen({super.key});

  @override
  State<NumbersQuizScreen> createState() => _NumbersQuizScreenState();
}

class _NumbersQuizScreenState extends State<NumbersQuizScreen> {
  final AudioPlayer player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {"number": "1", "sound": "1.mp3"},
    {"number": "2", "sound": "2.mp3"},
    {"number": "3", "sound": "3.mp3"},
    {"number": "4", "sound": "4.mp3"},
    {"number": "5", "sound": "5.mp3"},
    {"number": "6", "sound": "6.mp3"},
    {"number": "7", "sound": "7.mp3"},
    {"number": "8", "sound": "8.mp3"},
    {"number": "9", "sound": "9.mp3"},
    {"number": "10", "sound": "10.mp3"},
  ];

  final numbers = ["1","2","3","4","5","6","7","8","9","10"];

  int index = 0;
  int score = 0;

  List<String> options = [];

  bool showFeedback = false;
  bool isCorrect = false;
  bool showResult = false;
  String selected = "";

  Map<String, dynamic> get current => questions[index];
  String get correct => current["number"];
  String get sound => current["sound"];

  @override
  void initState() {
    super.initState();
    generateOptions();
    playSound();
  }

  Future<void> playSound() async {
    await player.stop();
    await player.play(AssetSource("sounds/$sound"));
  }

  void generateOptions() {
    final rand = Random();
    Set<String> temp = {correct};

    while (temp.length < 4) {
      temp.add(numbers[rand.nextInt(numbers.length)]);
    }

    options = temp.toList()..shuffle();
  }

  void reset() {
    setState(() {
      index = 0;
      score = 0;
      showFeedback = false;
      showResult = false;
      selected = "";
      generateOptions();
    });

    playSound();
  }

  void nextQuestion() async {
    if (index < questions.length - 1) {
      setState(() {
        index++;
        showFeedback = false;
        selected = "";
        generateOptions();
      });

      await playSound();
    } else {
      setState(() => showResult = true);
    }
  }

  void check(String value) async {
    if (showFeedback) return;

    setState(() {
      selected = value;
      showFeedback = true;
      isCorrect = value == correct;

      if (isCorrect) score++;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    nextQuestion();
  }

  Color getColor(String value) {
    if (!showFeedback) return GameColors.option;

    if (value == correct) return GameColors.correct;
    if (value == selected) return GameColors.wrong;

    return GameColors.disabled;
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
              : buildGame(),
        ),
      ),
    );
  }

  Widget buildGame() {
    return Column(
      children: [
        const SizedBox(height: 10),

        GameHeader(
          title: "اسمع الرقم 🎧",
          score: score,
        ),

        const SizedBox(height: 15),

        GameProgressBar(
          current: index,
          total: questions.length,
        ),

        const SizedBox(height: 25),

        GameCard(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: playSound,
                icon: const Icon(Icons.volume_up),
                label: const Text("إعادة الصوت"),
              ),

              const SizedBox(height: 15),

              if (showFeedback)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? AppColors.green : AppColors.red,
                  size: 60,
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, i) {
                final v = options[i];

                return GameOptionButton(
                  text: v,
                  color: getColor(v),
                  onTap: () => check(v),
                  disabled: showFeedback,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}