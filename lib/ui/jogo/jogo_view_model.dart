import 'package:flutter/foundation.dart';

import '../../data/repositories/jogo_repository.dart';
import '../../domain/aladdin_engine.dart';
import '../../domain/models/pergunta.dart';
import '../../domain/models/professor.dart';
import '../../domain/models/resposta.dart';

enum FaseJogo { pergunta, pensando, resultado }

class JogoViewModel extends ChangeNotifier {
  JogoViewModel(this._repository) {
    _engine = AladdinEngine(
      professores: _repository.professores(),
      perguntas: _repository.perguntas(),
    );
    reiniciar();
  }

  final JogoRepository _repository;
  late final AladdinEngine _engine;

  FaseJogo _fase = FaseJogo.pergunta;
  Pergunta? _perguntaAtual;
  Professor? _palpite;

  FaseJogo get fase => _fase;
  Pergunta? get perguntaAtual => _perguntaAtual;
  Professor? get palpite => _palpite;
  int get numeroPergunta => _engine.perguntasFeitas + 1;

  List<Professor> get professores => _engine.professores;

  Map<String, double> get escalasFotos => {
    for (final p in _engine.professores) p.id: _engine.escalaVisual(p),
  };

  double get proximidadeChute => _engine.proximidadeChute();

  void reiniciar() {
    _engine.iniciar();
    _palpite = null;
    _perguntaAtual = _engine.proximaPergunta();
    _fase = FaseJogo.pergunta;
    notifyListeners();
  }

  void continuar() {
    final descartado = _palpite;
    if (descartado == null) return;
    _engine.continuar(descartado);
    _palpite = null;
    _perguntaAtual = _engine.proximaPergunta();
    _fase = FaseJogo.pergunta;
    notifyListeners();
  }

  Future<void> responder(Resposta resposta) async {
    final pergunta = _perguntaAtual;
    if (pergunta == null || _fase != FaseJogo.pergunta) return;

    _engine.responder(pergunta, resposta);

    if (_engine.deveChutar) {
      _fase = FaseJogo.pensando;
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 1400));
      _palpite = _engine.lider;
      _fase = FaseJogo.resultado;
      notifyListeners();
    } else {
      _perguntaAtual = _engine.proximaPergunta();
      notifyListeners();
    }
  }
}
