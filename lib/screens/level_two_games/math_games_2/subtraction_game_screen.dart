import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';

class SubtractionGameScreen extends BaseMathGameScreen {
  const SubtractionGameScreen({super.key});

  @override
  String get title => "لعبة الطرح ➖";

  @override
  BaseMathGameState createState() => _SubtractionState();
}

class _SubtractionState extends BaseMathGameState<SubtractionGameScreen> {
  final List<String> shapes = ['🍎', '🌟', '🎈', '🍭', '🌸'];

  String shape = '🍎';

  @override
  int get correctAnswer => num1 - num2;  // ناتج الطرح

  @override
  void generateNumbers() {
    // نتأكد إن num1 أكبر من أو يساوي num2، والأرقام من 1 إلى 5
    num1 = random.nextInt(5) + 1;  // 1..5
    num2 = random.nextInt(num1) + 1; // 1..num1 → يضمن num2 <= num1
    shape = shapes[random.nextInt(shapes.length)];
  }

  @override
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // المجموعة الأولى (num1)
        Wrap(
          spacing: 6,
          children: List.generate(
            num1,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("-", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        // المجموعة الثانية (num2)
        Wrap(
          spacing: 6,
          children: List.generate(
            num2,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("= ?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    );
  }
}