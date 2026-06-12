import 'package:flutter/material.dart';

import 'fundo_estrelado.dart';
import 'tema.dart';

class AladdinScaffold extends StatelessWidget {
  const AladdinScaffold({
    super.key,
    required this.child,
    this.fundo,
    this.maxLargura = 460,
  });

  final Widget child;

  final Widget? fundo;

  final double maxLargura;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AladdinTema.fundoGradiente),
        child: Stack(
          children: [
            const Positioned.fill(child: FundoEstrelado()),
            Positioned.fill(child: fundo ?? const SizedBox.shrink()),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxLargura),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConteudoCentralizadoRolavel extends StatelessWidget {
  const ConteudoCentralizadoRolavel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final alturaMinima = (constraints.maxHeight - padding.vertical).clamp(
          0.0,
          double.infinity,
        );
        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: alturaMinima),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
