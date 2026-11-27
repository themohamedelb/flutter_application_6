// Importamos Flutter para crear el menú lateral:
import 'package:flutter/material.dart';

// Importamos las rutas para acceder a cada pantalla:
import '../routes/app_routes.dart';

// Creamos el menú lateral que compartiremos entre pantallas:
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Método encargado de cambiar de pantalla:
  void _navegar(BuildContext context, String ruta) {

    // Cerramos el menú antes de realizar la navegación:
    Navigator.pop(context);

    // Abrimos la pantalla seleccionada y evitamos acumular ejercicios:
    Navigator.pushNamedAndRemoveUntil(
      context,
      ruta,
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {

    // Construimos el menú lateral:
    return Drawer(
      backgroundColor: const Color(0xFF171A2E),
      child: SafeArea(
        child: Column(
          children: [

            // Encabezado con el nombre y el icono de la aplicación:
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6558D3),
                    Color(0xFF21B8A5),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.dashboard_customize,
                      color: Color(0xFF6558D3),
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'PIXEL STUDIO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mi colección de ejercicios',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Acceso a la pantalla inicial:
            _elemento(
              context,
              Icons.home_rounded,
              'Inicio',
              AppRoutes.home,
            ),

            // Acceso al ejercicio de Instagram:
            _elemento(
              context,
              Icons.camera_alt_rounded,
              'Instagram',
              AppRoutes.instagram,
            ),

            // Acceso al ejercicio de colores aleatorios:
            _elemento(
              context,
              Icons.palette_rounded,
              'Colores aleatorios',
              AppRoutes.colores,
            ),

            // Acceso al juego de imágenes:
            _elemento(
              context,
              Icons.ads_click_rounded,
              'Juego de imágenes',
              AppRoutes.juego,
            ),

            // Dejamos el espacio restante antes del pie del menú:
            const Spacer(),

            const Divider(color: Colors.white24),

            // Texto informativo al final del Drawer:
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'ENTREGA 5 · FLUTTER',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método reutilizable para crear las opciones del menú:
  Widget _elemento(
    BuildContext context,
    IconData icono,
    String texto,
    String ruta,
  ) {
    return ListTile(
      // Icono que representa cada apartado:
      leading: Icon(icono, color: const Color(0xFF21B8A5)),

      // Nombre de la pantalla:
      title: Text(
        texto,
        style: const TextStyle(color: Colors.white),
      ),

      // Flecha que indica que podemos acceder al apartado:
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white38,
        size: 15,
      ),

      // Ejecutamos la navegación cuando pulsamos la opción:
      onTap: () => _navegar(context, ruta),
    );
  }
}