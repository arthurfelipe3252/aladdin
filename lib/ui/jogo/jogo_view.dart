import 'package:flutter/material.dart';

import '../../data/repositories/jogo_repository.dart';
import '../core/app_scaffold.dart';
import '../core/fotos_flutuantes.dart';
import 'jogo_view_model.dart';
import 'widgets/pergunta_view.dart';
import 'widgets/pensando_view.dart';
import 'widgets/resultado_view.dart';

class JogoView extends StatefulWidget {
  const JogoView({super.key, required this.repository});

  final JogoRepository repository;

  @override
  State<JogoView> createState() => _JogoViewState();
}

class _JogoViewState extends State<JogoView> {
  late final JogoViewModel _viewModel = JogoViewModel(widget.repository);

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final fase = _viewModel.fase;
        return AladdinScaffold(
          fundo: fase == FaseJogo.pergunta
              ? FotosFlutuantes(
                  professores: _viewModel.professores,
                  escalas: _viewModel.escalasFotos,
                  proximidade: _viewModel.proximidadeChute,
                )
              : null,
          child: switch (fase) {
            FaseJogo.pergunta => PerguntaView(
              numero: _viewModel.numeroPergunta,
              pergunta: _viewModel.perguntaAtual!,
              onResponder: _viewModel.responder,
              onReiniciar: _viewModel.reiniciar,
            ),
            FaseJogo.pensando => const PensandoView(),
            FaseJogo.resultado => ResultadoView(
              professor: _viewModel.palpite!,
              onRecomecar: _viewModel.reiniciar,
              onContinuar: _viewModel.continuar,
            ),
          },
        );
      },
    );
  }
}
