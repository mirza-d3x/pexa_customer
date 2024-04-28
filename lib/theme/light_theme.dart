import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF0F4F7),
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFFf7d417),
  secondaryHeaderColor: const Color(0xFF2d2d2d),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFffec4e))), colorScheme: const ColorScheme.light(
    primary: Color(0xFFf9c43c),
    secondary: Color(0xFFf9c43c),
  ).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),
);

class ConstColors {
  static const Color primary = Color(0xFFf9c43c);
  static const amberColor = Color(0xFFffec4e);
}
