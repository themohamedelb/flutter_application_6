// Importamos la librería de pruebas de Flutter:
import 'package:flutter_test/flutter_test.dart';

// Importamos el archivo principal de nuestra aplicación:
import 'package:flutter_application_6/main.dart';

void main() {

  // Comprobamos que la aplicación se inicia correctamente:
  testWidgets(
    'Comprobar que se inicia la aplicacion',
    (WidgetTester tester) async {

      // Iniciamos nuestra aplicación principal:
      await tester.pumpWidget(const PixelStudioApp());

      // Comprobamos que aparece el nombre de la aplicación:
      expect(
        find.text('Pixel Studio'),
        findsOneWidget,
      );

      // Comprobamos que aparece el mensaje de bienvenida:
      expect(
        find.text('¡Bienvenido!'),
        findsOneWidget,
      );

      // Comprobamos que aparece la sección de actividades:
      expect(
        find.text('Mis actividades'),
        findsOneWidget,
      );
    },
  );
}
