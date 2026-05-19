import 'dart:math';
import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';


class DivisionGameScreen extends BaseMathGameScreen {
  const DivisionGameScreen({super.key});

  @override
  String get title => "لعبة القسمة ➗";

  @override
  BaseMathGameState<DivisionGameScreen> createState() => _DivisionGameState();
}

class _DivisionGameState extends BaseMathGameState<DivisionGameScreen> {
  final List<String> shapes = ['🍎', '🌟', '🎈', '🍭', '🌸', '🐧', '⭐', '🧸'];
  late String shape;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  @override
  int get correctAnswer => num1 ~/ num2; // ناتج القسمة

  @override
  void generateNumbers() {
    final random = Random(); // إذا لم يكن `random` موجوداً في BaseMathGameState
    int result = random.nextInt(3) + 1; // 1..3
    num2 = random.nextInt(3) + 1;       // 1..3
    num1 = num2 * result;               // المقسوم
    shape = shapes[random.nextInt(shapes.length)];
  }

  @override
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // المقسوم (num1) معروض كإيموجيات متكررة
        Wrap(
          spacing: 6,
          children: List.generate(
            num1.clamp(0, 20), // تجنب القيم الكبيرة جداً
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("÷", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        // المقسوم عليه (num2) يظهر كرقم
        Text("$num2", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const Text("= ؟", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    );
  }
}