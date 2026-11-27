// Importamos las herramientas para generar posiciones aleatorias:
import 'dart:math';

// Importamos Timer para controlar el tiempo del juego:
import 'dart:async';

// Importamos Flutter para crear la interfaz:
import 'package:flutter/material.dart';

// Importamos el Drawer común de la aplicación:
import '../drawer/app_drawer.dart';

// Pantalla del juego de reflejos:
class JuegoScreen extends StatefulWidget {
  const JuegoScreen({super.key});

  @override
  State<JuegoScreen> createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen> {

  // Generador de posiciones aleatorias:
  final Random random = Random();

  // Temporizador que controla cada ronda:
  Timer? temporizador;

  // Puntuación actual del jugador:
  int puntos = 0;

  // Segundos disponibles para pulsar el objetivo:
  int segundos = 3;

  // Indica si la partida está activa:
  bool jugando = false;

  // Coordenadas donde aparecerá la imagen:
  double posicionX = 0;
  double posicionY = 0;

  // Dimensiones disponibles para colocar el objetivo:
  double anchoZona = 0;
  double altoZona = 0;

  // Tamaño fijo de la imagen del juego:
  static const double tamanoObjetivo = 76;

  // Método que inicia una partida nueva:
  void iniciarJuego(double ancho, double alto) {

    // Cancelamos cualquier temporizador anterior:
    temporizador?.cancel();

    setState(() {

      // Reiniciamos los valores de la partida:
      puntos = 0;
      segundos = 3;
      jugando = true;

      // Guardamos el tamaño de la zona de juego:
      anchoZona = ancho;
      altoZona = alto;

      // Colocamos el objetivo en una posición aleatoria:
      _colocarObjetivo();
    });

    // Iniciamos la cuenta atrás:
    _iniciarReloj();
  }

  // Busca una posición aleatoria dentro de la zona:
  void _colocarObjetivo() {

    // Calculamos los límites máximos para evitar que salga fuera:
    final maxX = max(0.0, anchoZona - tamanoObjetivo);
    final maxY = max(0.0, altoZona - tamanoObjetivo);

    // Generamos las coordenadas aleatorias:
    posicionX = random.nextDouble() * maxX;
    posicionY = random.nextDouble() * maxY;
  }

  // Controla el tiempo disponible para cada objetivo:
  void _iniciarReloj() {

    // Evitamos tener varios temporizadores funcionando a la vez:
    temporizador?.cancel();

    // Ejecutamos una acción cada segundo:
    temporizador = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        // Detenemos el reloj si salimos de la pantalla:
        if (!mounted || !jugando) {
          timer.cancel();
          return;
        }

        // Comprobamos si se ha terminado el tiempo:
        if (segundos <= 1) {

          // Si no se ha pulsado, restamos dos puntos:
          _nuevaRonda(acierto: false);

        } else {

          // Restamos un segundo al contador:
          setState(() {
            segundos--;
          });
        }
      },
    );
  }

  // Actualiza la puntuación y prepara el siguiente objetivo:
  void _nuevaRonda({required bool acierto}) {

    // Detenemos el temporizador de la ronda anterior:
    temporizador?.cancel();

    // Comprobamos que la pantalla siga activa:
    if (!mounted || !jugando) return;

    setState(() {

      // Sumamos un punto si acertamos:
      if (acierto) {
        puntos++;
      } else {

        // Restamos dos puntos si no pulsamos a tiempo:
        puntos -= 2;
      }

      // Reiniciamos el contador:
      segundos = 3;

      // Cambiamos el objetivo de posición:
      _colocarObjetivo();
    });

    // Empezamos una nueva cuenta atrás:
    _iniciarReloj();
  }

  // Método que se ejecuta al pulsar la imagen:
  void pulsarObjetivo() {

    // No hacemos nada si la partida no está activa:
    if (!jugando) return;

    // Registramos el acierto:
    _nuevaRonda(acierto: true);
  }

  @override
  void dispose() {

    // Cancelamos el temporizador al salir de la pantalla:
    temporizador?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Creamos la estructura principal del juego:
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('Reflex Challenge'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.bolt),
          ),
        ],
      ),

      body: Column(
        children: [

          // Mostramos la puntuación y el tiempo restante:
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [

                // Indicador de puntos:
                Expanded(
                  child: _marcador(
                    'PUNTUACIÓN',
                    puntos.toString(),
                    Icons.emoji_events,
                    const Color(0xFF6558D3),
                  ),
                ),

                const SizedBox(width: 12),

                // Indicador del tiempo:
                Expanded(
                  child: _marcador(
                    'TIEMPO',
                    '$segundos s',
                    Icons.timer,
                    const Color(0xFF21B8A5),
                  ),
                ),
              ],
            ),
          ),

          // Instrucciones para el jugador:
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              '¡Atrapa el objetivo antes de que desaparezca!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF171A2E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Zona donde aparecerán las imágenes:
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {

                // Utilizamos el espacio disponible para colocar el objetivo:
                return Container(
                  margin: const EdgeInsets.all(14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9E5F8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFD5CFF0),
                      width: 2,
                    ),
                  ),

                  // Stack permite colocar el objetivo en distintas posiciones:
                  child: Stack(
                    children: [

                      // Mensaje inicial antes de comenzar:
                      if (!jugando)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.ads_click,
                                size: 75,
                                color: Color(0xFF6558D3),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                '¿Preparado para jugar?',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Consigue tantos puntos como puedas.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),

                              // Botón para iniciar la partida:
                              ElevatedButton.icon(
                                onPressed: () {
                                  iniciarJuego(
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  );
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('COMENZAR'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF6558D3),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Mostramos el objetivo mientras se está jugando:
                      if (jugando)
                        Positioned(
                          left: posicionX,
                          top: posicionY,
                          child: GestureDetector(

                            // Sumamos un punto cuando se pulsa la imagen:
                            onTap: pulsarObjetivo,

                            child: Container(
                              width: tamanoObjetivo,
                              height: tamanoObjetivo,
                              decoration: const BoxDecoration(
                                color: Color(0xFF6558D3),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),

                                // Cargamos la imagen del objetivo:
                                child: Image.asset(
                                  'assets/images/objetivo.png',
                                  fit: BoxFit.contain,

                                  // Mostramos un icono si no existe el archivo:
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.bolt,
                                      color: Colors.white,
                                      size: 45,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Botón para empezar de nuevo con cero puntos:
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {

                  // Reiniciamos utilizando las dimensiones guardadas:
                  if (anchoZona > 0 && altoZona > 0) {
                    iniciarJuego(anchoZona, altoZona);
                  }
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('REINICIAR PARTIDA'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método reutilizable para mostrar los indicadores del juego:
  Widget _marcador(
    String titulo,
    String valor,
    IconData icono,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          // Icono del indicador:
          Icon(icono, color: color, size: 26),

          const SizedBox(height: 7),

          // Nombre del indicador:
          Text(
            titulo,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          // Valor actual de la puntuación o del tiempo:
          Text(
            valor,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}