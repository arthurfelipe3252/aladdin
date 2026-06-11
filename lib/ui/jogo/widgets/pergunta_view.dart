import 'package:flutter/material.dart';

import '../../../domain/models/pergunta.dart';
import '../../../domain/models/resposta.dart';
import '../../core/app_scaffold.dart';
import '../../core/tema.dart';

class PerguntaView extends StatelessWidget {
  const PerguntaView({
    super.key,
    required this.numero,
    required this.pergunta,
    required this.onResponder,
    required this.onReiniciar,
  });

  final int numero;
  final Pergunta pergunta;
  final void Function(Resposta) onResponder;
  final VoidCallback onReiniciar;

  @override
  Widget build(BuildContext context) {
    return ConteudoCentralizadoRolavel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pergunta $numero',
                style: const TextStyle(
                  color: BionatorTema.destaqueClaro,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: onReiniciar,
                icon: const Icon(Icons.refresh),
                tooltip: 'Reiniciar',
              ),
            ],
          ),
          const Spacer(),
          Text(
            pergunta.texto,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 28),
          for (final resposta in Resposta.values)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () => onResponder(resposta),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    resposta.label,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
