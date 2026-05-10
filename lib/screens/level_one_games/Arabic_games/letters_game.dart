import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LettersGame extends StatefulWidget {
  const LettersGame({super.key});

  @override
  State<LettersGame> createState() => _LettersGameState();
}

class _LettersGameState extends State<LettersGame> {
  final List<Map<String, String>> letters = [
    {"letter": "أ", "word": "أسد", "emoji": "🦁"},
    {"letter": "ب", "word": "بطة", "emoji": "🦆"},
    {"letter": "ت", "word": "تفاحة", "emoji": "🍎"},
    {"letter": "ث", "word": "ثعلب", "emoji": "🦊"},
    {"letter": "ج", "word": "جمل", "emoji": "🐫"},
    {"letter": "ح", "word": "حصان", "emoji": "🐎"},
    {"letter": "خ", "word": "خروف", "emoji": "🐑"},
    {"letter": "د", "word": "دب", "emoji": "🐻"},
    {"letter": "ذ", "word": "ذئب", "emoji": "🐺"},
    {"letter": "ر", "word": "رمان", "emoji": "🍎"},
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
  final AudioPlayer player = AudioPlayer();

  String get currentLetter => letters[index]["letter"]!;
  String get currentWord => letters[index]["word"]!;
  String get currentEmoji => letters[index]["emoji"]!;

  void playSound() async {
    await player.stop();
    await player.play(AssetSource("sounds/$currentLetter.mp3"));
  }

  void nextLetter() {
    if (index < letters.length - 1) {
      setState(() => index++);
      playSound();
    }
  }

  void prevLetter() {
    if (index > 0) {
      setState(() => index--);
      playSound();
    }
  }

  // ───────── BACKGROUND ─────────
  Widget buildBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF81C784),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    playSound();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (index + 1) / letters.length;

    return Scaffold(
      body: buildBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                /// 🔝 HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Expanded(
                      child: Text(
                        "تعلم الحروف",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 20),

                /// 📊 PROGRESS
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "التقدم",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "${index + 1} / ${letters.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation(
                          Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// 🧠 CARD
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentEmoji,
                            style: const TextStyle(fontSize: 60)),
                        const SizedBox(height: 10),
                        Text(
                          currentLetter,
                          style: const TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentWord,
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),

                        ElevatedButton.icon(
                          onPressed: playSound,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          icon: const Icon(Icons.volume_up),
                          label: const Text("تكرار الصوت"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ⬅️➡️ BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: prevLetter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("السابق"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: nextLetter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("التالي"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}