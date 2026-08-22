import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2E7DFF);
  static const Color primaryDark = Color(0xFF1A56DB);
  static const Color background = Color(0xFFF7F9FC);
  static const Color cardBackground = Color(0xFFEFF4FF);
  static const Color textDark = Color(0xFF14213D);
  static const Color textGrey = Color(0xFF8B93A7);
  static const Color error = Color(0xFFE53E3E);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2E7DFF), Color(0xFF5B8DEF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}