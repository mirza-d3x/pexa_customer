import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFFffbd5c),
  secondaryHeaderColor: const Color(0xFF009f67),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFffbd5c))), colorScheme: const ColorScheme.dark(
      primary: Color(0xFFffbd5c), secondary: Color(0xFFffbd5c)).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);
