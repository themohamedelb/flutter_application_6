// Importamos Flutter para construir la pantalla:
import 'package:flutter/material.dart';

// Importamos el menú lateral:
import '../drawer/app_drawer.dart';

// Importamos las rutas de navegación:
import '../routes/app_routes.dart';

// Pantalla principal de Pixel Studio:
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Creamos la estructura principal de la pantalla:
    return Scaffold(
      // Añadimos el menú lateral.
      drawer: const AppDrawer(),

      // Barra superior con el nombre de la aplicación:
      appBar: AppBar(
        title: const Text('Pixel Studio'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.auto_awesome),
          ),
        ],
      ),

      // Permitimos desplazarnos si el contenido no cabe:
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Tarjeta de bienvenida con un fondo degradado:
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6558D3),
                    Color(0xFF8D78E8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.waving_hand,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(height: 15),
                  Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explora mis ejercicios de Flutter y descubre todo lo que puedes hacer.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Título de la sección de actividades:
            const Text(
              'Mis actividades',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171A2E),
              ),
            ),

            const SizedBox(height: 16),

            // Tarjeta para acceder a Instagram:
            _tarjeta(
              context,
              'Instagram',
              'Historias y publicaciones',
              Icons.camera_alt_rounded,
              const Color(0xFFF16C82),
              AppRoutes.instagram,
            ),

            // Tarjeta para acceder a los colores:
            _tarjeta(
              context,
              'Colores aleatorios',
              'Descubre nuevas combinaciones',
              Icons.color_lens_rounded,
              const Color(0xFF21B8A5),
              AppRoutes.colores,
            ),

            // Tarjeta para acceder al juego:
            _tarjeta(
              context,
              'Juego de imágenes',
              'Pon a prueba tus reflejos',
              Icons.ads_click_rounded,
              const Color(0xFFFFB454),
              AppRoutes.juego,
            ),
          ],
        ),
      ),
    );
  }

  // Creamos una tarjeta reutilizable para los ejercicios:
  Widget _tarjeta(
    BuildContext context,
    String titulo,
    String descripcion,
    IconData icono,
    Color color,
    String ruta,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        // Icono con el color correspondiente al ejercicio:
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icono, color: color),
        ),

        // Información de cada ejercicio:
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(descripcion),

        // Flecha de navegación:
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        // Abrimos la pantalla seleccionada:
        onTap: () => Navigator.pushNamed(context, ruta),
      ),
    );
  }
}