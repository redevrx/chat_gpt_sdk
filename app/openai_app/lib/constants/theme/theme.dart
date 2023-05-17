import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        titleSmall: GoogleFonts.openSans(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        titleMedium: GoogleFonts.openSans(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        displayMedium: GoogleFonts.openSans(
            fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.openSans(
            fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.openSans(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)));
