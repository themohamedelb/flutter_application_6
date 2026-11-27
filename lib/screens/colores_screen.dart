// Importamos Random para generar números aleatorios:
import 'dart:math';

// Importamos Flutter para crear la interfaz:
import 'package:flutter/material.dart';

// Importamos el Drawer compartido:
import '../drawer/app_drawer.dart';

// Pantalla encargada de generar colores aleatorios:
class ColoresScreen extends StatefulWidget {
  const ColoresScreen({super.key});

  @override
  State<ColoresScreen> createState() => _ColoresScreenState();
}

class _ColoresScreenState extends State<ColoresScreen> {

  // Creamos el generador de números aleatorios:
  final Random random = Random();

  // Lista que almacenará los ocho colores:
  late List<Color> paleta;

  @override
  void initState() {
    super.initState();

    // Generamos los colores cuando se abre la pantalla:
    generarPaleta();
  }

  // Crea un color utilizando valores RGB aleatorios:
  Color colorNuevo() {
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  // Sustituye todos los colores de la lista:
  void generarPaleta() {
    setState(() {
      paleta = List.generate(8, (_) => colorNuevo());
    });
  }

  // Cambia solamente el color de la tarjeta seleccionada:
  void cambiarColor(int index) {
    setState(() {
      paleta[index] = colorNuevo();
    });
  }

  @override
  Widget build(BuildContext context) {

    // Construimos la pantalla de generación de colores:
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('Color Lab'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.color_lens),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Título de la colección de colores:
            const Text(
              'Tu paleta de colores',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171A2E),
              ),
            ),

            const SizedBox(height: 8),

            // Explicación de cómo utilizar la pantalla:
            const Text(
              'Pulsa una tarjeta para cambiarla o genera una colección completamente nueva.',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // Mostramos los colores en dos columnas:
            Expanded(
              child: GridView.builder(
                itemCount: paleta.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),

                // Construimos cada tarjeta de color:
                itemBuilder: (context, index) {
                  final color = paleta[index];

                  return GestureDetector(
                    // Cambiamos el color cuando se pulsa la tarjeta:
                    onTap: () => cambiarColor(index),

                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      // Mostramos el código hexadecimal del color:
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.colorize,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Pulsa para cambiar',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botón para crear una paleta completamente nueva:
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: generarPaleta,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'GENERAR NUEVA PALETA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6558D3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}