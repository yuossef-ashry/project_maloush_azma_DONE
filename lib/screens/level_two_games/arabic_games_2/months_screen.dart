import 'package:flutter/material.dart';

import '../../common/widgets/game_background.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/game_progress_bar.dart';
import '../../common/widgets/game_card.dart';

class MonthsScreen extends StatefulWidget {
  const MonthsScreen({super.key});

  @override
  State<MonthsScreen> createState() => _MonthsScreenState();
}

class _MonthsScreenState extends State<MonthsScreen> {
  final List<Map<String, dynamic>> months = [
    {"number": "01", "name": "يناير", "season": "شتاء", "icon": "❄️"},
    {"number": "02", "name": "فبراير", "season": "شتاء", "icon": "❄️"},
    {"number": "03", "name": "مارس", "season": "ربيع", "icon": "🌸"},
    {"number": "04", "name": "أبريل", "season": "ربيع", "icon": "🌸"},
    {"number": "05", "name": "مايو", "season": "ربيع", "icon": "🌸"},
    {"number": "06", "name": "يونيو", "season": "صيف", "icon": "☀️"},
    {"number": "07", "name": "يوليو", "season": "صيف", "icon": "☀️"},
    {"number": "08", "name": "أغسطس", "season": "صيف", "icon": "☀️"},
    {"number": "09", "name": "سبتمبر", "season": "خريف", "icon": "🍂"},
    {"number": "10", "name": "أكتوبر", "season": "خريف", "icon": "🍂"},
    {"number": "11", "name": "نوفمبر", "season": "خريف", "icon": "🍂"},
    {"number": "12", "name": "ديسمبر", "season": "شتاء", "icon": "❄️"},
  ];

  int currentIndex = 0;

  Color getSeasonColor(String season) {
    switch (season) {
      case "شتاء":
        return const Color(0xFF42A5F5);

      case "ربيع":
        return const Color(0xFF66BB6A);

      case "صيف":
        return const Color(0xFFFFA726);

      case "خريف":
        return const Color(0xFFFF7043);

      default:
        return const Color(0xFF42A5F5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final month = months[currentIndex];
    final Color color = getSeasonColor(month["season"]);

    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ───────── HEADER ─────────
              const GameHeader(
                title: "شهور السنة",
                score: 0,
              ),

              const SizedBox(height: 10),

              // ───────── PROGRESS ─────────
              GameProgressBar(
                current: currentIndex,
                total: months.length,
              ),

              const SizedBox(height: 25),

              // ───────── MONTH CARD ─────────
              GameCard(
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          month["number"],
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      month["name"],
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${month["icon"]} ${month["season"]}",
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(months.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: i == currentIndex ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: i == currentIndex
                                ? color
                                : color.withOpacity(0.3),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ───────── MONTHS LIST ─────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(months.length, (i) {
                        final bool isSelected = i == currentIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = i;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.orange
                                  : Colors.white24,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              months[i]["name"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

              // ───────── BUTTONS ─────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: currentIndex > 0
                            ? () {
                          setState(() {
                            currentIndex--;
                          });
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          disabledBackgroundColor: Colors.white24,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "→ السابق",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentIndex < months.length - 1) {
                            setState(() {
                              currentIndex++;
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          currentIndex < months.length - 1
                              ? "← التالي"
                              : "تم ✓",
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