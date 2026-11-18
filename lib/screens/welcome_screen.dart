import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/city_art.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onEnter});
  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.navy,
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.spatial_audio_off_rounded,
                      color: Color(0xFF89DFC0),
                      size: 32,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'VozCidadã',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 34),
                const CityArt(),
                const SizedBox(height: 36),
                const Text(
                  'O seu bairro começa\ncom a sua voz.',
                  style: TextStyle(
                    fontSize: 36,
                    height: 1.1,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Encontre orientações sobre seus direitos, proponha melhorias e acompanhe as ideias que movem sua comunidade.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFFD1E0EA),
                  ),
                ),
                const SizedBox(height: 24),
                const Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Chip(
                      avatar: Icon(Icons.wifi_off_rounded, size: 18),
                      label: Text('Funciona offline'),
                    ),
                    Chip(
                      avatar: Icon(Icons.science_outlined, size: 18),
                      label: Text('Demonstração acadêmica'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onEnter,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Acessar o aplicativo'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sem cadastro. Dados e votos são temporários e reiniciam ao reabrir o aplicativo.',
                  style: TextStyle(
                    color: Color(0xFFD1E0EA),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
