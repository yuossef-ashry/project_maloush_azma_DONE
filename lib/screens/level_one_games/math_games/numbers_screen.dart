import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/app_colors.dart';


class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  final List<Map<String, String>> numbers = [
    {"num": "1", "word": "واحد"},
    {"num": "2", "word": "اثنين"},
    {"num": "3", "word": "ثلاثة"},
    {"num": "4", "word": "أربعة"},
    {"num": "5", "word": "خمسة"},
    {"num": "6", "word": "ستة"},
    {"num": "7", "word": "سبعة"},
    {"num": "8", "word": "ثمانية"},
    {"num": "9", "word": "تسعة"},
    {"num": "10", "word": "عشرة"},
  ];

  int index = 0;
  final AudioPlayer player = AudioPlayer();

  String get currentNumber => numbers[index]["num"]!;
  String get currentWord => numbers[index]["word"]!;

  @override
  void initState() {
    super.initState();
    playSound();
  }

  Future<void> playSound() async {
    try {
      await player.stop();
      await player.play(AssetSource("sounds/$currentNumber.mp3"));
    } catch (e) {
      debugPrint("Sound Error: $e");
    }
  }

  void next() {
    if (index < numbers.length - 1) {
      setState(() => index++);
      playSound();
    }
  }

  void prev() {
    if (index > 0) {
      setState(() => index--);
      playSound();
    }
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
          child: Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "تعلم الأرقام 🔢",
                score: index + 1,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: numbers.length,
              ),

              const SizedBox(height: 25),

              Expanded(
                child: GameCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentNumber,
                        style: const TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        currentWord,
                        style: const TextStyle(fontSize: 40),
                      ),

                      const SizedBox(height: 25),

                      GameOptionButton(
                        text: "🔊 تشغيل الصوت",
                        color: AppColors.primary ,
                        onTap: playSound,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: GameOptionButton(
                        text: "السابق",
                        color: AppColors.orange,                        onTap: prev,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GameOptionButton(
                        text: "التالي",
                        color: AppColors.orange,                        onTap: next,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}