import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card_learn.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> surahs = [
    {
      "name": "سورة الفاتحة",
      "number": "1",
      "ayahs": "7",
      "text":
      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَٰنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ",
      "meaning": "أم القرآن وتُقرأ في كل ركعة",
      "color": Color(0xFF1B5E20),
    },
    {
      "name": "سورة الإخلاص",
      "number": "112",
      "ayahs": "4",
      "text":
      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nقُلْ هُوَ اللَّهُ أَحَدٌ\nاللَّهُ الصَّمَدُ\nلَمْ يَلِدْ وَلَمْ يُولَدْ\nوَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
      "meaning": "تعدل ثلث القرآن الكريم",
      "color": Color(0xFF1565C0),
    },
    {
      "name": "سورة الكوثر",
      "number": "108",
      "ayahs": "3",
      "text":
      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nإِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ\nفَصَلِّ لِرَبِّكَ وَانْحَرْ\nإِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ",
      "meaning": "أقصر سورة في القرآن الكريم",
      "color": Color(0xFF6A1B9A),
    },
  ];

  Color getColor() {
    return surahs[currentIndex]["color"];
  }

  @override
  Widget build(BuildContext context) {
    final surah = surahs[currentIndex];
    final Color color = surah["color"];

    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ───────── HEADER ─────────
              const GameHeader(
                title: "تعلم القرآن الكريم",
                score: 0,
              ),

              const SizedBox(height: 10),

              // ───────── PROGRESS ─────────
              GameProgressBar(
                current: currentIndex,
                total: surahs.length,
              ),

              const SizedBox(height: 20),

              // ───────── SURAH CARD ─────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: GameCardLearn(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'سورة رقم ${surah["number"]}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            surah["name"],
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'عدد الآيات: ${surah["ayahs"]}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          const Divider(height: 20),

                          Text(
                            surah["text"],
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Divider(height: 20),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '💡 ${surah["meaning"]}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ───────── SURAH SELECTOR ─────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(surahs.length, (i) {
                    final isSelected = i == currentIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() => currentIndex = i);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.orange
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          surahs[i]["name"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 10),

              // ───────── BUTTONS ─────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: currentIndex > 0
                            ? () => setState(() => currentIndex--)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "→ السابق",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex =
                                (currentIndex + 1) % surahs.length;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          currentIndex < surahs.length - 1
                              ? "← التالي"
                              : "🔄 من البداية",
                          style: TextStyle(
                            fontSize: 18,
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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