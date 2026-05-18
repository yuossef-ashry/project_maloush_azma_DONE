import 'package:flutter/material.dart';

import '../../common/widgets/app_colors.dart';
import '../../common/widgets/app_constants.dart';

class GameCardLearnmonth extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;

  const GameCardLearnmonth({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(

        width: 400,
        height: 320,

        margin: const EdgeInsets.symmetric(horizontal: 20),

        padding:
        padding ??
            const EdgeInsets.all(AppConstants.cardPadding),

        decoration: BoxDecoration(

          color: const Color(0xFFFFF8E1),

          borderRadius: BorderRadius.circular(35),

          border: Border.all(
            color: Colors.orange,
            width: 3,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: child,
      ),
    );
  }
}