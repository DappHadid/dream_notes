import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Warna utama untuk gradasi
  static const Color primaryColor = Color(0xFF6A82FB); // Biru lembut
  static const Color secondaryColor = Color(0xFFB472E8); // Ungu dreamy

  // Warna teks dengan efek glow
  static final TextStyle glowingTextStyle = GoogleFonts.lato(
    color: Colors.white,
    shadows: [
      for (double i = 1; i < 4; i++)
        Shadow(color: Colors.purple.shade100, blurRadius: 3 * i),
    ],
  );

  static ThemeData get dreamyTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black, // Background dasar
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: Color(0xFF1a1a2e), // Warna background lebih gelap
      ),
      textTheme: TextTheme(
        // Style untuk judul seperti 'Log In' atau 'Register'
        headlineMedium: glowingTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        // Style untuk teks biasa
        bodyMedium: GoogleFonts.lato(color: Colors.white70),
      ),
      // Tema untuk input field
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.purple.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      // Tema untuk tombol
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor.withOpacity(0.8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
