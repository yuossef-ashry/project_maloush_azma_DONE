import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';

class SubtractionGameScreen extends BaseMathGameScreen {
  const SubtractionGameScreen({super.key});

  @override
  String get title => "لعبة الطرح ➖";
<<<<<<< HEAD

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
=======

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
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
<<<<<<< HEAD
        // المجموعة الأولى (num1)
=======
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
        Wrap(
          spacing: 6,
          children: List.generate(
            num1,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
<<<<<<< HEAD
        const Text("-", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        // المجموعة الثانية (num2)
=======
        const Text("-", style: TextStyle(fontSize: 28)),
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
        Wrap(
          spacing: 6,
          children: List.generate(
            num2,
                (_) => Text(shape, style: const TextStyle(fontSize: 32)),
          ),
        ),
<<<<<<< HEAD
        const Text("= ?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
=======
        const Text("= ?", style: TextStyle(fontSize: 28)),
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
      ],
    );
  }
}