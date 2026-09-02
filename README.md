# Coffee Break: Señal y Ruido — iOS

Aplicación Flutter orientada a iPhone. El catálogo se descarga dinámicamente desde `https://airsoto.github.io/vet/json/coffee_break_APP/coffee_break.json`.

El botón de información descarga de forma independiente `https://airsoto.github.io/vet/json/coffee_break_APP/coffeebreakinfo.json`, muestra la presentación del pódcast y sus colaboradores, y también conserva una caché local.

No se incluye una copia del catálogo en el paquete. La última respuesta válida se guarda en el directorio de soporte de la aplicación durante 12 horas y se usa como respaldo offline. Favoritos, listas, notas, historial y progreso se almacenan aparte mediante `SharedPreferences` y nunca modifican el JSON remoto.

## Abrir y compilar

1. Instala Flutter estable, Xcode y CocoaPods en macOS.
2. En la raíz ejecuta `flutter pub get`.
3. Ejecuta `cd ios && pod install && cd ..`.
4. Abre `ios/Runner.xcworkspace` en Xcode.
5. En Signing & Capabilities selecciona tu equipo y cambia el Bundle Identifier si fuera necesario.
6. Elige un simulador o iPhone y pulsa Run. También puedes usar `flutter run`.

## Codemagic

El flujo `ios-validation` de `codemagic.yaml` se ejecuta con cada envío a `main`: instala dependencias, analiza, prueba y compila una aplicación para el simulador iOS sin firma. Esto permite corregir cualquier incompatibilidad antes de configurar certificados.

Cuando la compilación inicial sea correcta, se añadirá un segundo flujo firmado para generar el IPA y enviarlo a TestFlight. Las claves de App Store Connect y los certificados deben guardarse únicamente en las integraciones protegidas de Codemagic.

Antes de distribuir, sustituye los iconos heredados de la plantilla y completa la ficha de privacidad en App Store Connect.

## Organización

- `lib/src/models.dart`: parser tolerante del catálogo, temas y referencias.
- `lib/src/repository.dart`: descarga, validación y caché del JSON.
- `lib/src/app_state.dart`: preferencias y contenido creado localmente.
- `lib/src/audio_controller.dart`: streaming, salto temporal y progreso.
- `lib/src/screens.dart`: episodios, búsqueda/filtros, ficha, biblioteca y ajustes.

Las listas creadas desde el buscador guardan los resultados como episodios o temas con timestamp. Al tocar un elemento temático, la reproducción comienza directamente en ese momento del audio.
