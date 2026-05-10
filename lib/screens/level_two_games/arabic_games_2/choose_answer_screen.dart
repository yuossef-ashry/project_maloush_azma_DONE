import 'package:flutter/material.dart';

class ChooseAnswerScreen extends StatefulWidget {
  const ChooseAnswerScreen({super.key});

  @override
  State<ChooseAnswerScreen> createState() => _ChooseAnswerScreenState();
}

class _ChooseAnswerScreenState extends State<ChooseAnswerScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🌵",
      "question": "أي حيوان يعيش في الصحراء؟",
      "options": ["قرد 🐒", "جمل 🐪", "بطة 🦆", "أرنب 🐰"],
      "correctOption": "جمل 🐪",
    },
    {
      "image": "🍎",
      "question": "ما هو لون التفاحة؟",
      "options": ["أزرق", "أحمر", "أصفر", "أخضر"],
      "correctOption": "أحمر",
    },
    {
      "image": "🌊",
      "question": "ما هو حيوان البحر؟",
      "options": ["سمكة 🐟", "أسد 🦁", "فيل 🐘", "ذئب 🐺"],
      "correctOption": "سمكة 🐟",
    },
    {
      "image": "🌳",
      "question": "أي حيوان يتسلق الأشجار؟",
      "options": ["قرد 🐒", "أسد 🦁", "فيل 🐘", "سمكة 🐟"],
      "correctOption": "قرد 🐒",
    },
    {
      "image": "🍌",
      "question": "ما هو لون الموزة؟",
      "options": ["أحمر", "أخضر", "أصفر", "أزرق"],
      "correctOption": "أصفر",
    },
    
    {
      "image": "🍇",
      "question": "ما هو لون العنب؟",
      "options": ["أصفر", "أحمر", "أرجواني", "أخضر"],
      "correctOption": "أرجواني",
    },
    {
      "image": "🌿",
      "question": "ما هو لون الشجرة؟",
      "options": ["أزرق", "أخضر", "أحمر", "أصفر"],
      "correctOption": "أخضر",
    },
    {
      "image": "👁️",
      "question": "بماذا نرى؟",
      "options": ["بالأذن", "بالعين", "بالأنف", "بالفم"],
      "correctOption": "بالعين",
    },
    {
      "image": "🌙",
      "question": "متى يظهر القمر؟",
      "options": ["الصباح", "الظهر", "الليل", "العصر"],
      "correctOption": "الليل",
    },
    {
      "image": "🎨",
      "question": "ما هو لون السماء؟",
      "options": ["أحمر", "أخضر", "أصفر", "أزرق"],
      "correctOption": "أزرق",
    },
    {
      "image": "☀️",
      "question": "متى تشرق الشمس؟",
      "options": ["الليل", "الصباح", "المساء", "الظهر"],
      "correctOption": "الصباح",
    },
    {
      "image": "👂",
      "question": "بماذا نسمع؟",
      "options": ["بالعين", "بالأنف", "بالأذن", "باليد"],
      "correctOption": "بالأذن",
    },
    {
      "image": "🌧️",
      "question": "من أين تنزل الأمطار؟",
      "options": ["البحر", "الجبل", "السماء", "الأرض"],
      "correctOption": "السماء",
    },
    {
      "image": "👃",
      "question": "بماذا نشم؟",
      "options": ["بالفم", "بالأنف", "بالعين", "بالأذن"],
      "correctOption": "بالأنف",
    },
    {
      "image": "☀️",
      "question": "متى تشرق الشمس؟",
      "options": ["الليل", "الصباح", "المساء", "الظهر"],
      "correctOption": "الصباح",
    },
    {
      "image": "🌧️",
      "question": "من أين تنزل الأمطار؟",
      "options": ["البحر", "الجبل", "السماء", "الأرض"],
      "correctOption": "السماء",
    },
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedAnswer;
  List<bool> visibleOptions = [true, true, true, true];

  void checkAnswer(int optionIndex) {
    if (selectedAnswer != null) return;
    String selected = questions[currentIndex]["options"][optionIndex];
    String correct = questions[currentIndex]["correctOption"];
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
            builder: (_) => ChooseAnswerResultScreen(
                score: score, total: questions.length),
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
            colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
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
                    const Text('اختر الإجابة الصحيحة',
                        style: TextStyle(color: Colors.white, fontSize: 18,
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
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 18,
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
                    Text(q["question"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                    Color btnColor = const Color(0xFF9C27B0);
                    if (selectedAnswer == i) {
                      btnColor = options[i] == q["correctOption"]
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
                              style: const TextStyle(fontSize: 18,
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

class ChooseAnswerResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ChooseAnswerResultScreen(
      {super.key, required this.score, required this.total});

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
                          builder: (_) => const ChooseAnswerScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('إعادة اللعب',
                      style: TextStyle(fontSize: 18, color: Color(0xFF9C27B0))),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
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