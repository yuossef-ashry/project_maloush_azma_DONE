import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';
import '../../common/widgets/game_option_button.dart';
import '../../common/widgets/app_colors.dart';

class LettersGame extends StatefulWidget {
  const LettersGame({super.key});

  @override
  State<LettersGame> createState() => _LettersGameState();
}

class _LettersGameState extends State<LettersGame> {
  final AudioPlayer player = AudioPlayer();

  final List<Map<String, String>> letters = const [
    {"letter": "أ", "word": "أسد", "emoji": "🦁"},
    {"letter": "ب", "word": "بطة", "emoji": "🦆"},
    {"letter": "ت", "word": "تفاحة", "emoji": "🍎"},
    {"letter": "ث", "word": "ثعلب", "emoji": "🦊"},
    {"letter": "ج", "word": "جمل", "emoji": "🐫"},
    {"letter": "ح", "word": "حصان", "emoji": "🐎"},
    {"letter": "خ", "word": "خروف", "emoji": "🐑"},
    {"letter": "د", "word": "دب", "emoji": "🐻"},
    {"letter": "ذ", "word": "ذئب", "emoji": "🐺"},
    {"letter": "ر", "word": "رمان", "emoji": "🍉"},
    {"letter": "ز", "word": "زهرة", "emoji": "🌸"},
    {"letter": "س", "word": "سمكة", "emoji": "🐟"},
    {"letter": "ش", "word": "شمس", "emoji": "☀️"},
    {"letter": "ص", "word": "صقر", "emoji": "🦅"},
    {"letter": "ض", "word": "ضفدع", "emoji": "🐸"},
    {"letter": "ط", "word": "طائرة", "emoji": "✈️"},
    {"letter": "ظ", "word": "ظرف", "emoji": "✉️"},
    {"letter": "ع", "word": "عصفور", "emoji": "🐦"},
    {"letter": "غ", "word": "غزال", "emoji": "🦌"},
    {"letter": "ف", "word": "فيل", "emoji": "🐘"},
    {"letter": "ق", "word": "قطة", "emoji": "🐱"},
    {"letter": "ك", "word": "كرة", "emoji": "⚽"},
    {"letter": "ل", "word": "ليمون", "emoji": "🍋"},
    {"letter": "م", "word": "موز", "emoji": "🍌"},
    {"letter": "ن", "word": "نجمة", "emoji": "⭐"},
    {"letter": "ه", "word": "هلال", "emoji": "🌙"},
    {"letter": "و", "word": "وردة", "emoji": "🌹"},
    {"letter": "ي", "word": "يد", "emoji": "✋"},
  ];

  int index = 0;

  String get currentLetter => letters[index]["letter"]!;
  String get currentWord => letters[index]["word"]!;
  String get currentEmoji => letters[index]["emoji"]!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => playSound());
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> playSound() async {
    try {
      await player.stop();
      await player.play(AssetSource("sounds/$currentLetter.mp3"));
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void next() {
    if (index < letters.length - 1) {
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

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              GameHeader(
                title: "تعلم الحروف",
                score: index + 1,
              ),

              const SizedBox(height: 10),

              GameProgressBar(
                current: index,
                total: letters.length,
              ),

              const SizedBox(height: 25),

              Expanded(
                child: GameCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentEmoji,
                        style: const TextStyle(fontSize: 70),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        currentLetter,
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        currentWord,
                        style: const TextStyle(fontSize: 30),
                      ),

                      const SizedBox(height: 20),

                      GameOptionButton(
                        text: "تكرار الصوت 🔊",
                        color: AppColors.orange,
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
                        color: AppColors.primary,
                        onTap: prev,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GameOptionButton(
                        text: "التالي",
                        color: AppColors.primary,
                        onTap: next,
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