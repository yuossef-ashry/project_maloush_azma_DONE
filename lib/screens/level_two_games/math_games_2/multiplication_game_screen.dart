import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';

class MultiplicationGameScreen extends BaseMathGameScreen {
  const MultiplicationGameScreen({super.key});

  @override
  String get title => "لعبة الضرب ✖";

  @override
  BaseMathGameState createState() => _MultiplicationState();
}

<<<<<<< HEAD
class _MultiplicationState extends BaseMathGameState<MultiplicationGameScreen> {
  final List<String> shapes = ['🍎', '🌟', '🎈', '🍭', '🌸'];

  String shape = '🍎';
=======
class _MultiplicationState
    extends BaseMathGameState<MultiplicationGameScreen> {
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8

  @override
  int get correctAnswer => num1 * num2;

  @override
  void generateNumbers() {
<<<<<<< HEAD
    // نستخدم أرقام صغيرة من 1 إلى 3 لتكون مناسبة للعرض بالإيموجي
    num1 = random.nextInt(3) + 1; // 1..3
    num2 = random.nextInt(3) + 1; // 1..3
    shape = shapes[random.nextInt(shapes.length)];
=======
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
  }

  @override
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
<<<<<<< HEAD
        // المجموعة الأولى (num1)
        Wrap(
          spacing: 6,
          children: List.generate(
            num1,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("×", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        // المجموعة الثانية (num2)
        Wrap(
          spacing: 6,
          children: List.generate(
            num2,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const Text("= ؟", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
=======

        Text(
          "$num1 × $num2 = ؟",
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
      ],
    );
  }
}