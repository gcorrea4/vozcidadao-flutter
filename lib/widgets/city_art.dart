import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Ilustração local construída com widgets: não depende de rede ou fontes.
class CityArt extends StatelessWidget {
  const CityArt({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Uma comunidade conectada por ideias',
    image: true,
    child: ExcludeSemantics(
      child: SizedBox(
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 4,
              right: 30,
              child: Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  color: Color(0xFF294B61),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Positioned(
              top: 10,
              left: 18,
              child: Icon(
                Icons.forum_rounded,
                size: 55,
                color: Color(0xFF89DFC0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _building(48, 85, const Color(0xFF5D90A2)),
                const SizedBox(width: 9),
                _building(65, 130, const Color(0xFFA5DACD)),
                const SizedBox(width: 9),
                _building(52, 105, const Color(0xFF579F90)),
                const SizedBox(width: 9),
                _building(42, 65, const Color(0xFFDBE7E7)),
              ],
            ),
            const Positioned(
              bottom: 0,
              right: 8,
              child: Icon(
                Icons.park_rounded,
                size: 85,
                color: Color(0xFF62BA92),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _building(double width, double height, Color color) => Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
    ),
    child: Wrap(
      spacing: 7,
      runSpacing: 10,
      children: List.generate(
        8,
        (_) => Container(
          width: 8,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.navy.withValues(alpha: .55),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    ),
  );
}
