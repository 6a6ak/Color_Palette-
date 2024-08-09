import 'package:flutter/material.dart';
import 'package:color_pallete/pages/styles/colors.dart';

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    color: AppColors.ink,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    color: AppColors.disable,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 18,
    color: AppColors.ink,
  );

  static const TextStyle appbar = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.ink,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle buttonOutlinedText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.ember,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    color: AppColors.ink,
  );

  static const TextStyle largeText = TextStyle(
    fontSize: 30,
    color: AppColors.ink,
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.ember, //
    foregroundColor: Colors.white, //
    textStyle: buttonText, //
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.ember, // ه
    textStyle: buttonOutlinedText, //
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    side: const BorderSide(color: AppColors.ember),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
