import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  static const header = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const score = TextStyle(
    fontSize: 18,
    color: AppColors.white,
  );

  static const question = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
  );

  static const normal = TextStyle(
    fontSize: 20,
  );

  static const option = TextStyle(
    fontSize: 26,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const resultTitle = TextStyle(
    fontSize: 28,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
}