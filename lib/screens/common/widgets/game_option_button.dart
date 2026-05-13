import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_text_styles.dart';

class GameOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final bool disabled;

  const GameOptionButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          disabled ? AppColors.disabled : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonRadius,
            ),
          ),
        ),

        onPressed: disabled ? null : onTap,

        child: Text(
          text,
          style: AppTextStyles.option,
        ),
      ),
    );
  }
}