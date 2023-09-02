import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janganan/utils/constants/colors.dart';

final colorScheme = ColorScheme.fromSeed(seedColor: AppColor.primaryColor);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: colorScheme,
  primaryColor: AppColor.primaryColor,
  textTheme: GoogleFonts.mPlus1pTextTheme().copyWith(
    titleLarge: GoogleFonts.mPlus1p(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    titleMedium: GoogleFonts.mPlus1p(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    titleSmall: GoogleFonts.mPlus1p(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    bodySmall: GoogleFonts.mPlus1p(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey,
    ),
  ),
);
