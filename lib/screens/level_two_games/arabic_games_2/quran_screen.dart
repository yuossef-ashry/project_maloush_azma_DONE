import 'package:flutter/material.dart';

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
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَٰنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ",
      "meaning": "هي أم القرآن وتُقرأ في كل ركعة من الصلاة",
      "color": const Color(0xFF1B5E20),
    },
    {
      "name": "سورة الإخلاص",
      "number": "112",
      "ayahs": "4",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nقُلْ هُوَ اللَّهُ أَحَدٌ\nاللَّهُ الصَّمَدُ\nلَمْ يَلِدْ وَلَمْ يُولَدْ\nوَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
      "meaning": "تعدل ثلث القرآن الكريم",
      "color": const Color(0xFF1565C0),
    },
    {
      "name": "سورة الكوثر",
      "number": "108",
      "ayahs": "3",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nإِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ\nفَصَلِّ لِرَبِّكَ وَانْحَرْ\nإِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ",
      "meaning": "أقصر سورة في القرآن الكريم",
      "color": const Color(0xFF6A1B9A),
    },
    {
      "name": "سورة الناس",
      "number": "114",
      "ayahs": "6",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nقُلْ أَعُوذُ بِرَبِّ النَّاسِ\nمَلِكِ النَّاسِ\nإِلَٰهِ النَّاسِ\nمِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ\nالَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ",
      "meaning": "آخر سورة في القرآن الكريم",
      "color": const Color(0xFFBF360C),
    },
    {
      "name": "سورة الفلق",
      "number": "113",
      "ayahs": "5",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nقُلْ أَعُوذُ بِرَبِّ الْفَلَقِ\nمِن شَرِّ مَا خَلَقَ\nوَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ\nوَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ\nوَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ",
      "meaning": "من المعوذتين التي تحمي من الشر",
      "color": const Color(0xFF004D40),
    },
    {
      "name": "سورة المسد",
      "number": "111",
      "ayahs": "5",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nتَبَّتْ يَدَا أَبِي لَهَبٍ وَتَبَّ\nمَا أَغْنَىٰ عَنْهُ مَالُهُ وَمَا كَسَبَ\nسَيَصْلَىٰ نَارًا ذَاتَ لَهَبٍ\nوَامْرَأَتُهُ حَمَّالَةَ الْحَطَبِ\nفِي جِيدِهَا حَبْلٌ مِّن مَّسَدٍ",
      "meaning": "نزلت في أبي لهب وزوجته",
      "color": const Color(0xFFE65100),
    },
    {
      "name": "سورة النصر",
      "number": "110",
      "ayahs": "3",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nإِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ\nوَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا\nفَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا",
      "meaning": "نزلت في فتح مكة",
      "color": const Color(0xFF00838F),
    },
    {
      "name": "سورة الكافرون",
      "number": "109",
      "ayahs": "6",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\nقُلْ يَا أَيُّهَا الْكَافِرُونَ\nلَا أَعْبُدُ مَا تَعْبُدُونَ\nوَلَا أَنْتُمْ عَابِدُونَ مَا أَعْبُدُ\nوَلَا أَنَا عَابِدٌ مَا عَبَدْتُمْ\nوَلَا أَنْتُمْ عَابِدُونَ مَا أَعْبُدُ\nلَكُمْ دِينُكُمْ وَلِيَ دِينِ",
      "meaning": "سورة التوحيد والبراءة من الشرك",
      "color": const Color(0xFF2E7D32),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final surah = surahs[currentIndex];
    final Color color = surah["color"] as Color;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
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
                    const Text(
                      'تعلم القرآن الكريم',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(surahs.length, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == currentIndex ? Colors.white : Colors.white38,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
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
                        const Divider(height: 24),
                        Text(
                          surah["text"],
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 20,
                            height: 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(height: 24),
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    if (currentIndex > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => currentIndex--),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            '→ السابق',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    if (currentIndex > 0) const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentIndex < surahs.length - 1) {
                            setState(() => currentIndex++);
                          } else {
                            setState(() => currentIndex = 0);
                          }
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
                              ? '← التالي'
                              : '🔄 من البداية',
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}