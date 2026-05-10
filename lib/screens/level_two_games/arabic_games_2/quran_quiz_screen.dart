import 'package:flutter/material.dart';

class QuranQuizScreen extends StatefulWidget {
  const QuranQuizScreen({super.key});

  @override
  State<QuranQuizScreen> createState() => _QuranQuizScreenState();
}

class _QuranQuizScreenState extends State<QuranQuizScreen> {
  int quizIndex = 0;
  int score = 0;
  int? selectedAnswer;
  List<bool> visibleOptions = [true, true, true, true];

  final List<Map<String, dynamic>> questions = [
    {
      "question": "كم عدد آيات سورة الفاتحة؟",
      "options": ["5", "6", "7", "8"],
      "correctOption": "7",
    },
    {
      "question": "ما هي السورة التي تُسمى (أم القرآن)؟",
      "options": ["الإخلاص", "الفاتحة", "الكوثر", "الناس"],
      "correctOption": "الفاتحة",
    },
    {
      "question": "كم عدد آيات سورة الإخلاص؟",
      "options": ["3", "4", "5", "6"],
      "correctOption": "4",
    },
    {
      "question": "ما معنى سورة الإخلاص؟",
      "options": ["تعدل ثلث القرآن", "أقصر سورة", "آخر سورة", "تحمي من الشر"],
      "correctOption": "تعدل ثلث القرآن",
    },
    {
      "question": "ما هي أقصر سورة في القرآن؟",
      "options": ["الفاتحة", "الإخلاص", "الكوثر", "الناس"],
      "correctOption": "الكوثر",
    },
    {
      "question": "كم عدد آيات سورة الكوثر؟",
      "options": ["2", "3", "4", "5"],
      "correctOption": "3",
    },
    {
      "question": "ما هي آخر سورة في القرآن؟",
      "options": ["الفلق", "الكوثر", "الإخلاص", "الناس"],
      "correctOption": "الناس",
    },
    {
      "question": "كم عدد آيات سورة الناس؟",
      "options": ["4", "5", "6", "7"],
      "correctOption": "6",
    },
    {
      "question": "ما هي السورة التي تحمي من الشر؟",
      "options": ["الفلق", "المسد", "النصر", "الكافرون"],
      "correctOption": "الفلق",
    },
    {
      "question": "في سورة المسد، ماذا قيل عن أبي لهب؟",
      "options": ["سيدخل النار", "سيدخل الجنة", "سيعفو الله عنه", "سيتوب"],
      "correctOption": "سيدخل النار",
    },
    {
      "question": "كم عدد آيات سورة النصر؟",
      "options": ["2", "3", "4", "5"],
      "correctOption": "3",
    },
    {
      "question": "ماذا قال الله في سورة الكافرون؟",
      "options": [
        "لكم دينكم ولي دين",
        "الله أحد",
        "إنا أعطيناك الكوثر",
        "تبت يدا أبي لهب",
      ],
      "correctOption": "لكم دينكم ولي دين",
    },
  ];

  void checkAnswer(int optionIndex) {
    if (selectedAnswer != null) return;
    String selected = questions[quizIndex]["options"][optionIndex];
    String correct = questions[quizIndex]["correctOption"];
    setState(() {
      selectedAnswer = optionIndex;
      if (selected == correct) score++;
      for (int i = 0; i < 4; i++) {
        if (i != optionIndex) visibleOptions[i] = false;
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (quizIndex < questions.length - 1) {
        setState(() {
          quizIndex++;
          selectedAnswer = null;
          visibleOptions = [true, true, true, true];
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                QuranQuizResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[quizIndex];
    final List<String> options = List<String>.from(q["options"]);
    final String correct = q["correctOption"];
    final bool answered = selectedAnswer != null;
    final bool isWrong = answered && options[selectedAnswer!] != correct;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ========== الرأس ==========
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ✅ زر الرجوع (اتصلح)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("إلغاء الاختبار"),
                            content: const Text(
                              "هل تريد الخروج من الاختبار؟ سيتم فقدان التقدم.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("إكمال"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "خروج",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    const Text(
                      'اختبار القرآن',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // عداد الدرجات
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$score',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // شريط التقدم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(questions.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 25,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i <= quizIndex ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // السؤال
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  q["question"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // الخيارات
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
                    Color btnColor = const Color(0xFF388E3C);
                    if (selectedAnswer == i) {
                      btnColor = options[i] == correct
                          ? Colors.green
                          : Colors.red;
                    }
                    return GestureDetector(
                      onTap: () => checkAnswer(i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            options[i],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // رسالة الإجابة الصحيحة عند الخطأ
              if (isWrong)
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'الإجابة الصحيحة: $correct',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 8),

              // رقم السؤال
              Text(
                'السؤال ${quizIndex + 1} من ${questions.length}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== شاشة النتيجة =====================

class QuranQuizResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const QuranQuizResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  String getMessage() {
    double percentage = (score / total) * 100;
    if (percentage >= 80) return 'ممتاز! 🎉';
    if (percentage >= 60) return 'جيد جداً! 👍';
    if (percentage >= 40) return 'جيد، حاول مرة أخرى 📖';
    return 'لا تيأس، واصل التعلم 💪';
  }

  @override
  Widget build(BuildContext context) {
    int stars = score >= total * 0.8
        ? 3
        : score >= total * 0.5
        ? 2
        : 1;

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  Text(
                    getMessage(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'درجتك: $score / $total',
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
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
                          builder: (_) => const QuranQuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'إعادة الاختبار',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'الرئيسية',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
