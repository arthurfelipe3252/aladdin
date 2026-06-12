import 'package:flutter/material.dart';

import '../../data/repositories/jogo_repository.dart';
import '../core/app_scaffold.dart';
import '../core/tema.dart';
import '../jogo/jogo_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.repository});

  final JogoRepository repository;

  void _comecar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => JogoView(repository: repository)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AladdinScaffold(
      child: ConteudoCentralizadoRolavel(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🧞', style: TextStyle(fontSize: 76)),
            const SizedBox(height: 8),
            Text(
              'Aladdin',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: AladdinTema.destaqueClaro,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pense num professor do curso… eu adivinho!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const _ComoJogar(),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _comecar(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AladdinTema.destaque,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'COMEÇAR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComoJogar extends StatelessWidget {
  const _ComoJogar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AladdinTema.destaque.withValues(alpha: 0.35)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Como jogar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AladdinTema.destaqueClaro,
            ),
          ),
          SizedBox(height: 12),
          _Passo(numero: '1', texto: 'Pense em um professor do curso.'),
          _Passo(numero: '2', texto: 'Responda às perguntas que eu fizer.'),
          _Passo(numero: '3', texto: 'No final, eu tento cravar quem é!'),
          SizedBox(height: 14),
          Text(
            'Responda com: Sim · Provavelmente sim · Não sei · '
            'Provavelmente não · Não',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _Passo extends StatelessWidget {
  const _Passo({required this.numero, required this.texto});

  final String numero;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AladdinTema.destaque,
            child: Text(
              numero,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(texto, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
