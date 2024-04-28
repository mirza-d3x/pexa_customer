import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

defaultFont(
    {Color? color = Colors.black,
    double? size = 14,
    FontWeight weight = FontWeight.w500}) {
  return GoogleFonts.nunito(
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}
