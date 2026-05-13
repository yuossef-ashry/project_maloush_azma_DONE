import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

class GameProgress extends StatelessWidget {

  final int current;

  final int total;

  const GameProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      child: Row(
        children: List.generate(
          total,

              (i) {

            return Expanded(
              child: Container(
                margin:
                const EdgeInsets.symmetric(
                  horizontal: 2,
                ),

                height:
                AppConstants.progressHeight,

                decoration: BoxDecoration(
                  color: i <= current
                      ? AppColors.white
                      : AppColors.white30,

                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}