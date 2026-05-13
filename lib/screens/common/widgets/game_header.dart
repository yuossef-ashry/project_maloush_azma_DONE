import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_text_styles.dart';

class GameHeader extends StatelessWidget {

  final String title;

  final int score;

  const GameHeader({
    super.key,
    required this.title,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(
        AppConstants.screenPadding,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),

          Text(
            title,
            style: AppTextStyles.header,
          ),

          Row(
            children: [

              const Icon(
                Icons.star,
                color: AppColors.amber,
              ),

              const SizedBox(width: 5),

              Text(
                "$score",
                style: AppTextStyles.score,
              ),
            ],
          ),
        ],
      ),
    );
  }
}