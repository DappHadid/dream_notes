import 'dart:math';
import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';

// Ganti 'dream_notes' dengan nama project Anda
import 'package:dream_notes/utils/app_theme.dart';

class DreamyBackground extends StatelessWidget {
  const DreamyBackground({super.key, required this.child});

  final Widget child;

  List<Particle> createStarParticles() {
    final Random rng = Random();
    final List<Particle> particles = [];

    for (int i = 0; i < 80; i++) {
      // BENAR: Menggunakan konstruktor dengan parameter yang DIWAJIBKAN
      // sesuai screenshot Anda.
      particles.add(
        Particle(
          color: Colors.white.withOpacity(rng.nextDouble() * 0.8 + 0.2),
          size: rng.nextDouble() * 2 + 0.5,
          velocity: Offset(
            (rng.nextDouble() - 0.5) * 0.5,
            (rng.nextDouble() - 0.5) * 0.5,
          ),
        ),
      );
    }
    return particles;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Layer 1: Gradasi
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1a1a2e), // Biru gelap
                Color(0xFF2e1a47), // Ungu gelap
                AppTheme.primaryColor,
              ],
            ),
          ),
        ),

        // Layer 2: Partikel Bintang
        Particles(
          particles: createStarParticles(),
          height: screenSize.height,
          width: screenSize.width,
          onTapAnimation: true,
          awayRadius: 100,
          awayAnimationDuration: const Duration(milliseconds: 400),
          awayAnimationCurve: Curves.easeOut,
          enableHover: false,
          connectDots: false,
        ),

        // Layer 3: Konten Utama
        Scaffold(backgroundColor: Colors.transparent, body: child),
      ],
    );
  }
}
