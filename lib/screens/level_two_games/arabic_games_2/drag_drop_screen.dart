import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "image": "🐱",
      "correctWord": "قطة",
      "options": ["قطة", "كلب", "بطة"],
    },
    {
      "image": "🐶",
      "correctWord": "كلب",
      "options": ["قطة", "كلب", "فيل"],
    },
    {
      "image": "🐘",
      "correctWord": "فيل",
      "options": ["أسد", "جمل", "فيل"],
    },
    {
      "image": "🦁",
      "correctWord": "أسد",
      "options": ["أسد", "قرد", "بطة"],
    },
    {
      "image": "🐪",
      "correctWord": "جمل",
      "options": ["فيل", "جمل", "ذئب"],
    },
    {
      "image": "🍎",
      "correctWord": "تفاحة",
      "options": ["موزة", "تفاحة", "برتقال"],
    },
    {
      "image": "🍌",
      "correctWord": "موزة",
      "options": ["موزة", "عنب", "تفاحة"],
    },
    {
      "image": "🍊",
      "correctWord": "برتقال",
      "options": ["تفاحة", "موزة", "برتقال"],
    },
  ];

  int currentIndex = 0;
  int score = 0;
  String? droppedWord;
  bool? isCorrect;

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        droppedWord = null;
        isCorrect = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DragDropResultScreen(
              score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                    const Text('السحب والإفلات',
                        style: TextStyle(color: Colors.white, fontSize: 22,
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

              // Progress
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

              // Image + Drop Zone
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(q["image"], style: const TextStyle(fontSize: 100)),
                    const SizedBox(height: 16),
                    const Text('اسحب الكلمة الصحيحة وضعها على الصورة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 16),

                    // Drop Zone
                    DragTarget<String>(
                      onAcceptWithDetails: (details) {
                        setState(() {
                          droppedWord = details.data;
                          isCorrect = details.data == q["correctWord"];
                          if (isCorrect!) score++;
                        });
                        Future.delayed(const Duration(seconds: 1), nextQuestion);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: droppedWord == null
                                ? Colors.grey.shade100
                                : isCorrect!
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: droppedWord == null
                                  ? Colors.grey.shade300
                                  : isCorrect!
                                  ? Colors.green
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              droppedWord ?? '؟',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: droppedWord == null
                                    ? Colors.grey
                                    : isCorrect!
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Draggable Words
              const Text('👇 اسحب الكلمة الصحيحة',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (q["options"] as List<String>).map((word) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Draggable<String>(
                      data: word,
                      feedback: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(word,
                            style: const TextStyle(fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      childWhenDragging: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(word,
                            style: const TextStyle(fontSize: 22,
                                color: Colors.white54)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(word,
                            style: const TextStyle(fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DragDropResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const DragDropResultScreen(
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
                          builder: (_) => const DragDropScreen()),
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
                      style: TextStyle(fontSize: 18,
                          color: Color(0xFF26C6DA))),
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