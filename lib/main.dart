import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/checklist_screen.dart';
import 'screens/home_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/timer_screen.dart';
import 'services/ad_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AdService.instance.initialize();

  runApp(const BraaiBossApp());
}

class BraaiBossApp extends StatelessWidget {
  const BraaiBossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braai Boss',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('af'),
      ],
      theme: BraaiTheme.light(),
      home: const HomeScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.routeName: (_) => const HomeScreen(),
        RecipesScreen.routeName: (_) => const RecipesScreen(),
        TimerScreen.routeName: (_) => const TimerScreen(),
        ChecklistScreen.routeName: (_) => const ChecklistScreen(),
      },
    );
  }
}

class BraaiTheme {
  static ThemeData light() {
    const Color braaiOrange = Color(0xFFE76F51);
    const Color braaiRed = Color(0xFFB23A2F);
    const Color braaiBrown = Color(0xFF6F3D2E);

    const Color saGreen = Color(0xFF007A4D);
    const Color saYellow = Color(0xFFFFB612);
    const Color saBlue = Color(0xFF002395);

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: braaiOrange,
      brightness: Brightness.light,
    ).copyWith(
      primary: braaiOrange,
      secondary: saGreen,
      tertiary: saYellow,
      error: braaiRed,
      surface: const Color(0xFFFFF7F1),
      outline: saBlue.withOpacity(0.30),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: saBlue.withOpacity(0.18),
            width: 1.0,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.secondary.withOpacity(0.10),
        labelStyle: TextStyle(
          color: scheme.secondary,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: scheme.secondary.withOpacity(0.35),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          height: 1.25,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: braaiBrown.withOpacity(0.12),
        thickness: 1.0,
        space: 24.0,
      ),
    );
  }
}
