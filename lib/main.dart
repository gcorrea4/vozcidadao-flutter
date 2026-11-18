import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/app_shell.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const VozCidadaApp());

class VozCidadaApp extends StatelessWidget {
  const VozCidadaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'VozCidadã',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale('pt', 'BR')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: Builder(
      builder: (context) => WelcomeScreen(
        onEnter: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const AppShell()),
        ),
      ),
    ),
  );
}
