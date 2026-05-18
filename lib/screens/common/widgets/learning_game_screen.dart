import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card_learn.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/app_colors.dart';

class LearningGameScreen extends StatefulWidget {
  final String title;
  final List<Map<String, String>> items;
  final Color mainColor;

  const LearningGameScreen({
    super.key,
    required this.title,
    required this.items,
    required this.mainColor,
  });

  @override
  State<LearningGameScreen> createState() => _LearningGameScreenState();
}

class _LearningGameScreenState extends State<LearningGameScreen> {
  final AudioPlayer player = AudioPlayer();

  int index = 0;

  Map<String, String> get currentItem => widget.items[index];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      playSound();
    });
  }

  Future<void> playSound() async {
    try {
      await player.stop();

      await player.play(
        AssetSource(
          "sounds/${currentItem["sound"]}.mp3",
        ),
      );
    } catch (e) {
      debugPrint("Sound Error: $e");
    }
  }

  void next() {
    if (index < widget.items.length - 1) {
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
                title: widget.title,
                score: index + 1,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: widget.items.length,
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GameCardLearn(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if (currentItem["emoji"] != null)
                        Text(
                          currentItem["emoji"]!,
                          style: const TextStyle(fontSize: 70),
                        ),

                      const SizedBox(height: 10),

                      Text(
                        currentItem["main"]!,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: widget.mainColor,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        currentItem["word"]!,
                        style: const TextStyle(fontSize: 35),
                      ),

                      const SizedBox(height: 25),

                      GameOptionButton(
                        text: "🔊 تشغيل الصوت",
                        color: AppColors.primary,
                        onTap: playSound,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: GameOptionButton(
                        text: "السابق",
                        color: AppColors.orange,
                        onTap: prev,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: GameOptionButton(
                        text: "التالي",
                        color: AppColors.orange,
                        onTap: next,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}