import 'dart:math';

import 'package:flutter/material.dart';

class FundoEstrelado extends StatefulWidget {
  const FundoEstrelado({super.key});

  @override
  State<FundoEstrelado> createState() => _FundoEstreladoState();
}

class _FundoEstreladoState extends State<FundoEstrelado>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _EstrelasPainter(_controller),
      ),
    );
  }
}

const int _qtdEstrelas = 52;
const int _semente = 20240611;

class _EstrelasPainter extends CustomPainter {
  _EstrelasPainter(this.animacao) : super(repaint: animacao);

  final Animation<double> animacao;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(_semente);
    final paint = Paint();
    final t = animacao.value;
    for (var i = 0; i < _qtdEstrelas; i++) {
      final x = rng.nextDouble();
      final y = rng.nextDouble();
      final raio = 0.6 + rng.nextDouble() * 1.9;
      final opacidade = 0.10 + rng.nextDouble() * 0.40;
      final fase = rng.nextDouble();
      final velocidade = 0.6 + rng.nextDouble() * 1.4;
      final brilho = 0.5 + 0.5 * sin(2 * pi * (t * velocidade + fase));
      paint.color = Colors.white.withValues(
        alpha: (opacidade * (0.3 + 0.7 * brilho)).clamp(0.0, 1.0),
      );
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        raio * (0.85 + 0.3 * brilho),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _EstrelasPainter oldDelegate) => false;
}
