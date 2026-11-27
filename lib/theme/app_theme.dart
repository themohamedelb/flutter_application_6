// Importamos Flutter para poder crear el tema:
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData temaPrincipal = ThemeData(
    useMaterial3: true,

    // Definimos el color de fondo general:
    scaffoldBackgroundColor: const Color(0xFFF4F2FA),

    // Definimos los colores principales:
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6558D3),
      primary: const Color(0xFF6558D3),
      secondary: const Color(0xFF21B8A5),
    ),

    // Personalizamos la barra superior:
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF171A2E),
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
    ),

    // Personalizamos los estilos de los textos:
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color(0xFF171A2E),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF171A2E),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF171A2E),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF333333),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF555555),
      ),
    ),

    // Personalizamos los botones:
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6558D3),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    // Personalizamos las tarjetas:
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
  );
}
