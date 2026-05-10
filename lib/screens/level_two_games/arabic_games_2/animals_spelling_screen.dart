import 'package:flutter/material.dart';

class AnimalsSpellingScreen extends StatefulWidget {
  const AnimalsSpellingScreen({super.key});

  @override
  State<AnimalsSpellingScreen> createState() => _AnimalsSpellingScreenState();
}

class _AnimalsSpellingScreenState extends State<AnimalsSpellingScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🦁",
      "word": "أسد",
      "missing": "س",
      "display": "أ؟د",
      "options": ["س", "ش", "ص", "ز"],
    },
    {
      "image": "🐘",
      "word": "فيل",
      "missing": "ي",
      "display": "ف؟ل",
      "options": ["ا", "و", "ي", "ة"],
    },
    {
      "image": "🐪",
      "word": "جمل",
      "missing": "م",
      "display": "ج؟ل",
      "options": ["ح", "م", "خ", "ك"],
    },
    {
      "image": "🦊",
      "word": "ثعلب",
      "missing": "ع",
      "display": "ث؟لب",
      "options": ["ع", "غ", "أ", "ح"],
    },
    {
      "image": "🐺",
      "word": "ذئب",
      "missing": "ئ",
      "display": "ذ؟ب",
      "options": ["ئ", "ي", "و", "ا"],
    },
    {
      "image": "🐒",
      "word": "قرد",
      "missing": "ر",
      "display": "ق؟د",
      "options": ["ر", "ز", "و", "ن"],
    },
    {
      "image": "🐊",
      "word": "تمساح",
      "missing": "س",
      "display": "تم؟اح",
      "options": ["س", "ش", "ص", "ث"],
    },
    {
      "image": "🦒",
      "word": "زرافة",
      "missing": "ا",
      "display": "زر؟فة",
      "options": ["ا", "و", "ي", "ة"],
    },
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedAnswer;
  List<bool> visibleOptions = [true, true, true, true];

  void checkAnswer(int optionIndex) {
    if (selectedAnswer != null) return;
    String selected = questions[currentIndex]["options"][optionIndex];
    String correct = questions[currentIndex]["missing"];
    setState(() {
      selectedAnswer = optionIndex;
      if (selected == correct) score++;
      for (int i = 0; i < 4; i++) {
        if (i != optionIndex) visibleOptions[i] = false;
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedAnswer = null;
          visibleOptions = [true, true, true, true];
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AnimalsResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];
    final List<String> options = List<String>.from(q["options"]);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF26C6DA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                    const Text('إملاء أسماء الحيوانات',
                        style: TextStyle(color: Colors.white, fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 20),
                          const SizedBox(width: 4),
                          Text('$score', style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(questions.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 30,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i <= currentIndex ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(q["image"], style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 16),
                    const Text('أكمل اسم الحيوان:',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Text(
                      selectedAnswer != null &&
                          options[selectedAnswer!] == q["missing"]
                          ? q["word"]
                          : q["display"],
                      style: const TextStyle(fontSize: 36,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                  children: List.generate(4, (i) {
                    if (!visibleOptions[i]) return const SizedBox();
                    Color btnColor = const Color(0xFF4FC3F7);
                    if (selectedAnswer == i) {
                      btnColor = options[i] == q["missing"]
                          ? Colors.green : Colors.red;
                    }
                    return GestureDetector(
                      onTap: () => checkAnswer(i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(options[i],
                              style: const TextStyle(fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimalsResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const AnimalsResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    int stars = score >= total * 0.8 ? 3 : score >= total * 0.5 ? 2 : 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF81C784)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 16),
                const Text('أحسنت!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Text('درجتك: $score / $total',
                    style: const TextStyle(fontSize: 22, color: Colors.white)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Icon(
                      Icons.star,
                      size: 40,
                      color: i < stars ? Colors.yellow : Colors.white38,
                    );
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AnimalsSpellingScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('إعادة اللعب',
                      style: TextStyle(fontSize: 18, color: Color(0xFF4FC3F7))),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('الرئيسية',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
