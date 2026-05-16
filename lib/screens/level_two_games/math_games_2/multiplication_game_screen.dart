import 'package:flutter/material.dart';
import '../../common/widgets/base_math_game_screen.dart';

class MultiplicationGameScreen extends BaseMathGameScreen {
  const MultiplicationGameScreen({super.key});

  @override
  String get title => "لعبة الضرب ✖";

  @override
  BaseMathGameState createState() => _MultiplicationState();
}

class _MultiplicationState
    extends BaseMathGameState<MultiplicationGameScreen> {

  @override
  int get correctAnswer => num1 * num2;

  @override
  void generateNumbers() {
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;
  }

  @override
  Widget buildQuestion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          "$num1 × $num2 = ؟",
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

      ],
    );
  }
}