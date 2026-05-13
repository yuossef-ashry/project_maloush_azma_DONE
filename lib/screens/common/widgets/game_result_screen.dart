import 'package:flutter/material.dart';

class GameResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const GameResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    int stars = (score / total * 3).round();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("🏆", style: TextStyle(fontSize: 90)),
          const SizedBox(height: 10),

          const Text(
            "أحسنت!",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),

          Text(
            "درجتك: $score / $total",
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 10),

          // ⭐ Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (i) => Icon(
                Icons.star,
                color: i < stars ? Colors.amber : Colors.white30,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ───── BUTTONS ─────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onRestart,
                child: const Text("إعادة اللعب"),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text("خروج"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}