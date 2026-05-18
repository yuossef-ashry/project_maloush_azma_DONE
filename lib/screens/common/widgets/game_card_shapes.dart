import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

class GameCardShapes extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;

  const GameCardShapes({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(

        width: 400,
        height: 200,

        margin: const EdgeInsets.symmetric(horizontal: 20),

        padding: padding ?? const EdgeInsets.all(AppConstants.cardPadding),

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black26,
              blurRadius: 10,
            ),
          ],
        ),

        child: child,
      ),
    );
  }
}