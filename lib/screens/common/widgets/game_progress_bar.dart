import 'package:flutter/material.dart';

class GameProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const GameProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(total, (i) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 8,
              decoration: BoxDecoration(
                color: i <= current ? Colors.white : Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }),
      ),
    );
  }
}