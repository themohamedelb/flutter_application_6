// Importamos Flutter para construir la interfaz:
import 'package:flutter/material.dart';

// Importamos el menú lateral compartido:
import '../drawer/app_drawer.dart';

// Pantalla que imita una red social de fotografías:
class InstagramScreen extends StatelessWidget {
  const InstagramScreen({super.key});

  // Lista de imágenes que utilizaremos en historias y publicaciones:
  static const List<String> fotos = [
    'assets/images/foto_01.jpg',
    'assets/images/foto_02.jpg',
    'assets/images/foto_03.jpg',
    'assets/images/foto_04.jpg',
    'assets/images/foto_05.jpg',
    'assets/images/foto_06.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    // Estructura principal de Instagram:
    return Scaffold(
      drawer: const AppDrawer(),

      // Barra superior de la pantalla:
      appBar: AppBar(
        title: const Text('InstaSpace'),
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 18),
        ],
      ),

      // Organizamos el perfil, las historias y las publicaciones:
      body: Column(
        children: [

          // Sección con la información del perfil:
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFF6558D3),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(width: 25),

                // Número de publicaciones:
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        '24',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Publicaciones'),
                    ],
                  ),
                ),

                // Número de seguidores:
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        '850',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Seguidores'),
                    ],
                  ),
                ),

                // Número de personas seguidas:
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        '320',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Seguidos'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Descripción del perfil:
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mi espacio creativo ✨',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Lista horizontal de historias:
          SizedBox(
            height: 112,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fotos.length + 1,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              // Construimos cada historia según su posición:
              itemBuilder: (context, index) {
                if (index == 0) {
                  // La primera opción permite añadir una historia:
                  return _historiaNueva();
                }

                // Las demás opciones muestran fotografías:
                return _historia(index);
              },
            ),
          ),

          const Divider(height: 20),

          // Título de la cuadrícula:
          const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grid_on, color: Color(0xFF6558D3)),
                SizedBox(width: 8),
                Text(
                  'PUBLICACIONES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // Mostramos las imágenes en una cuadrícula de tres columnas:
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(3),
              itemCount: fotos.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),

              // Cargamos cada fotografía:
              itemBuilder: (context, index) {
                return Image.asset(
                  fotos[index],
                  fit: BoxFit.cover,

                  // Mostramos un color alternativo si falla una imagen:
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.primaries[
                        index % Colors.primaries.length
                      ],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Creamos la primera historia para añadir contenido:
  Widget _historiaNueva() {
    return const SizedBox(
      width: 83,
      child: Column(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: Color(0xFFE5E0F7),
            child: Icon(
              Icons.add,
              color: Color(0xFF6558D3),
              size: 30,
            ),
          ),
          SizedBox(height: 7),
          Text('Tu historia', style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  // Creamos las historias de los demás usuarios:
  Widget _historia(int index) {
    final foto = fotos[index - 1];

    return SizedBox(
      width: 83,
      child: Column(
        children: [
          // Borde degradado alrededor de cada fotografía:
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF16C82),
                  Color(0xFFFFB454),
                  Color(0xFF6558D3),
                ],
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  foto,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,

                  // Mostramos un icono si no se encuentra la imagen:
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 7),

          // Nombre del usuario:
          Text(
            'Usuario $index',
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}