// Importamos Flutter para utilizar WidgetBuilder:
import 'package:flutter/material.dart';

// Importamos las pantallas que tendrá nuestra aplicación:
import '../screens/home_screen.dart';
import '../screens/instagram_screen.dart';
import '../screens/colores_screen.dart';
import '../screens/juego_screen.dart';

// Clase encargada de organizar la navegación:
class AppRoutes {

  // Creamos una ruta para cada pantalla:
  static const String home = '/';
  static const String instagram = '/instagram';
  static const String colores = '/colores';
  static const String juego = '/juego';

  // Relacionamos cada ruta con su correspondiente pantalla:
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    instagram: (context) => const InstagramScreen(),
    colores: (context) => const ColoresScreen(),
    juego: (context) => const JuegoScreen(),
  };
}