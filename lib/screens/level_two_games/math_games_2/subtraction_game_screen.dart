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
  int get correctAnswer => num1 - num2;

  @override
  void generateNumbers() {
    num1 = random.nextInt(10) + 5;
    num2 = random.nextInt(5) + 1;

    // ضمان إن الناتج مايبقاش سالب
    if (num2 > num1) {
      final temp = num1;
      num1 = num2;
      num2 = temp;
    }

    shape = shapes[random.nextInt(shapes.length)];
  }

  @override
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 6,
          children: List.generate(
            num1,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("-", style: TextStyle(fontSize: 28)),
        Wrap(
          spacing: 6,
          children: List.generate(
            num2,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("= ?", style: TextStyle(fontSize: 28)),
      ],
    );
  }
}