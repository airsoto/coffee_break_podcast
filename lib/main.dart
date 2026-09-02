import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'src/app_state.dart';
import 'src/audio_controller.dart';
import 'src/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = AppState();
  await state.initialize();
  runApp(CoffeeBreakApp(state: state));
}

class CoffeeBreakApp extends StatelessWidget {
  const CoffeeBreakApp({super.key, required this.state});
  final AppState state;
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: state),
      ChangeNotifierProvider(create: (_) => AudioController(state)),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Break: Señal y Ruido',
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD89B52), brightness: Brightness.dark, surface: const Color(0xFF151311)),
        scaffoldBackgroundColor: const Color(0xFF0D0C0B),
        useMaterial3: true,
        cardTheme: const CardThemeData(color: Color(0xFF191714)),
        navigationBarTheme: const NavigationBarThemeData(backgroundColor: Color(0xFF151311), indicatorColor: Color(0x554ECDC4)),
      ),
      home: const RootScreen(),
    ),
  );
}
