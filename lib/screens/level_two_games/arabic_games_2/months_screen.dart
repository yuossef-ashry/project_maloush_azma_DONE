import 'package:flutter/material.dart';

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
  int? selectedMonth;

  Color getSeasonColor(String season) {
    switch (season) {
      case "شتاء": return const Color(0xFF4FC3F7);
      case "ربيع": return const Color(0xFF81C784);
      case "صيف": return const Color(0xFFFFB74D);
      case "خريف": return const Color(0xFFFF8A65);
      default: return const Color(0xFF4FC3F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    final month = months[currentIndex];
    final color = getSeasonColor(month["season"]);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.6)],
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
                    const Text('شهور السنة',
                        style: TextStyle(color: Colors.white, fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text('${currentIndex + 1} / ${months.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),

              // Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(
                  value: (currentIndex + 1) / months.length,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              // Month Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(month["number"],
                            style: const TextStyle(fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(month["name"],
                        style: const TextStyle(fontSize: 36,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${month["icon"]} ${month["season"]}',
                          style: TextStyle(fontSize: 18, color: color,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(months.length, (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == currentIndex ? color : color.withOpacity(0.3),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Months Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: List.generate(months.length, (i) {
                      bool isSelected = i == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.orange : Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(months[i]["name"],
                              style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 14)),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // Buttons
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
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('→ السابق',
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: currentIndex < months.length - 1
                            ? () => setState(() => currentIndex++)
                            : () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          currentIndex < months.length - 1 ? '← التالي' : 'تم ✓',
                          style: TextStyle(fontSize: 18, color: color),
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