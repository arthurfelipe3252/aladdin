import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../domain/models/professor.dart';
import 'tema.dart';

class FotosFlutuantes extends StatefulWidget {
  const FotosFlutuantes({
    super.key,
    required this.professores,
    required this.escalas,
    required this.proximidade,
    this.raioMax = 50,
    this.opacidade = 0.6,
  });

  final List<Professor> professores;

  final Map<String, double> escalas;

  final double proximidade;

  final double raioMax;
  final double opacidade;

  @override
  State<FotosFlutuantes> createState() => _FotosFlutuantesState();
}

const int _sementeMovimento = 91;

class _FotosFlutuantesState extends State<FotosFlutuantes>
    with SingleTickerProviderStateMixin {
  static const double _velMin = 1.0;
  static const double _velMax = 9.0;

  late final Ticker _ticker;

  final ValueNotifier<double> _fase = ValueNotifier<double>(0);
  double _faseTempo = 0;
  double _ultimoElapsed = 0;
  double _fatorAtual = 1;

  late final List<Widget> _avatares = [
    for (final p in widget.professores)
      _AvatarCirculo(
        foto: p.foto,
        raio: widget.raioMax,
        opacidade: widget.opacidade,
      ),
  ];

  late final List<double> _escalas = List<double>.filled(
    widget.professores.length,
    0,
  );

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      final agora = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
      final dt = agora - _ultimoElapsed;
      _ultimoElapsed = agora;
      final fatorAlvo =
          _velMin + (_velMax - _velMin) * widget.proximidade.clamp(0.0, 1.0);
      _fatorAtual += (fatorAlvo - _fatorAtual) * 0.05;
      _faseTempo += dt * _fatorAtual;
      _fase.value = _faseTempo;
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _fase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _fase,
        builder: (context, _) {
          final tempo = _fase.value;
          final rng = Random(_sementeMovimento);
          final filhos = <Widget>[];
          for (var i = 0; i < widget.professores.length; i++) {
            final ax = _coordenada(rng, tempo);
            final ay = _coordenada(rng, tempo);
            final alvo = widget.escalas[widget.professores[i].id] ?? 0;
            _escalas[i] += (alvo - _escalas[i]) * 0.08;
            filhos.add(
              Align(
                alignment: Alignment(ax.clamp(-1.0, 1.0), ay.clamp(-1.0, 1.0)),
                child: Transform.scale(scale: _escalas[i], child: _avatares[i]),
              ),
            );
          }
          return Stack(children: filhos);
        },
      ),
    );
  }

  double _coordenada(Random rng, double tempo) {
    final a1 = 0.70 + rng.nextDouble() * 0.18;
    final f1 = 0.005 + rng.nextDouble() * 0.010;
    final p1 = rng.nextDouble() * 2 * pi;
    final a2 = 0.06 + rng.nextDouble() * 0.10;
    final f2 = 0.010 + rng.nextDouble() * 0.018;
    final p2 = rng.nextDouble() * 2 * pi;
    return a1 * sin(2 * pi * f1 * tempo + p1) +
        a2 * sin(2 * pi * f2 * tempo + p2);
  }
}

class _AvatarCirculo extends StatelessWidget {
  const _AvatarCirculo({
    required this.foto,
    required this.raio,
    required this.opacidade,
  });

  final String foto;
  final double raio;
  final double opacidade;

  @override
  Widget build(BuildContext context) {
    final diametro = raio * 2;
    return Container(
      width: diametro,
      height: diametro,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AladdinTema.fundoTopo,
        border: Border.all(
          color: AladdinTema.destaque.withValues(alpha: opacidade),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AladdinTema.destaque.withValues(alpha: 0.3 * opacidade),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          foto,
          width: diametro,
          height: diametro,
          fit: BoxFit.cover,
          opacity: AlwaysStoppedAnimation(opacidade),
        ),
      ),
    );
  }
}
