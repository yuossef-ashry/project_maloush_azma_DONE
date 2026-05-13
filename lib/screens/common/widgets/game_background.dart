import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  final Widget child;

  const GameBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF81C784),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}