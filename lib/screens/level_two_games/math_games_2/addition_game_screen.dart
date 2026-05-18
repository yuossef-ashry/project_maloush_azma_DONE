import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';




class AdditionGameScreen extends BaseMathGameScreen {
  const AdditionGameScreen({super.key});

  @override
  String get title => "لعبة الجمع ➕";

  @override
  BaseMathGameState createState() => _AdditionState();
}

class _AdditionState extends BaseMathGameState<AdditionGameScreen> {
  final List<String> shapes = ['🍎', '🌟', '🎈', '🍭', '🌸'];

  String shape = '🍎';

  @override
  int get correctAnswer => num1 + num2;

  @override
  void generateNumbers() {
    num1 = random.nextInt(5) + 1;
    num2 = random.nextInt(5) + 1;
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
        const Text("+", style: TextStyle(fontSize: 28)),
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