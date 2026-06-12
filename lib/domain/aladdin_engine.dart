import 'dart:math';

import 'models/pergunta.dart';
import 'models/professor.dart';
import 'models/resposta.dart';

class AladdinEngine {
  AladdinEngine({
    required this.professores,
    required this.perguntas,
    this.pisoPerguntas = 4,
    this.gapParaChute = 8,
    this.margemEmJogo = 4,
    this.gapAposErro = 3,
    this.aberturasAleatorias = 3,
    this.topAleatorio = 5,
    Random? random,
  }) : _random = random ?? Random();

  final List<Professor> professores;
  final List<Pergunta> perguntas;

  final int pisoPerguntas;

  final int gapParaChute;

  final int margemEmJogo;

  final int gapAposErro;

  final int aberturasAleatorias;

  final int topAleatorio;

  final Random _random;

  final Map<String, int> _pontos = {};
  final Set<String> _perguntasFeitas = {};
  final Set<String> _gruposBloqueados = {};
  final Set<String> _eliminados = {};

  int _perguntasMinimas = 0;

  void iniciar() {
    _pontos
      ..clear()
      ..addEntries(professores.map((p) => MapEntry(p.id, 0)));
    _perguntasFeitas.clear();
    _gruposBloqueados.clear();
    _eliminados.clear();
    _perguntasMinimas = pisoPerguntas;
  }

  int get perguntasFeitas => _perguntasFeitas.length;

  int pontosDe(Professor p) => _pontos[p.id] ?? 0;

  List<Professor> get _ativos =>
      professores.where((p) => !_eliminados.contains(p.id)).toList();

  List<Professor> get ranking {
    final lista = _ativos;
    lista.sort((a, b) => pontosDe(b).compareTo(pontosDe(a)));
    return lista;
  }

  Professor get lider => ranking.first;

  int get gapLider {
    final r = ranking;
    if (r.length < 2) return 1 << 30;
    return pontosDe(r[0]) - pontosDe(r[1]);
  }

  List<Professor> get emJogo {
    final topo = pontosDe(lider);
    return _ativos.where((p) => topo - pontosDe(p) <= margemEmJogo).toList();
  }

  double escalaVisual(Professor p, {double passo = 8}) {
    if (_eliminados.contains(p.id)) return 0;
    final escala = 1 + pontosDe(p) / passo;
    return escala < 0 ? 0 : escala;
  }

  void responder(Pergunta pergunta, Resposta resposta) {
    _perguntasFeitas.add(pergunta.id);
    for (final p in _ativos) {
      _pontos[p.id] = pontosDe(p) + p.traco(pergunta.id) * resposta.valor;
    }
    final grupo = pergunta.grupoExclusao;
    if (grupo != null && resposta == Resposta.sim) {
      _gruposBloqueados.add(grupo);
    }
  }

  void continuar(Professor descartado) {
    _eliminados.add(descartado.id);
    _perguntasMinimas = perguntasFeitas + gapAposErro;
  }

  bool _disponivel(Pergunta q) {
    if (_perguntasFeitas.contains(q.id)) return false;
    final grupo = q.grupoExclusao;
    if (grupo != null && _gruposBloqueados.contains(grupo)) return false;
    return true;
  }

  Pergunta? _selecionar(List<Professor> candidatos, {required bool aleatorio}) {
    final pontuadas = <(Pergunta, int)>[];
    for (final q in perguntas) {
      if (!_disponivel(q)) continue;
      var sim = 0;
      var nao = 0;
      for (final p in candidatos) {
        if (p.traco(q.id) == 1) {
          sim++;
        } else {
          nao++;
        }
      }
      final score = min(sim, nao);
      if (score > 0) pontuadas.add((q, score));
    }
    if (pontuadas.isEmpty) return null;
    pontuadas.sort((a, b) => b.$2.compareTo(a.$2));
    if (!aleatorio) return pontuadas.first.$1;
    final tamanhoSorteio = min(topAleatorio, pontuadas.length);
    return pontuadas[_random.nextInt(tamanhoSorteio)].$1;
  }

  Pergunta? _qualquerDisponivel() {
    for (final q in perguntas) {
      if (_disponivel(q)) return q;
    }
    return null;
  }

  Pergunta? proximaPergunta() {
    final aleatorio = perguntasFeitas < aberturasAleatorias;
    return _selecionar(emJogo, aleatorio: aleatorio) ??
        _selecionar(_ativos, aleatorio: aleatorio) ??
        _qualquerDisponivel();
  }

  double proximidadeChute() {
    if (deveChutar) return 1;
    final confianca = (gapLider / gapParaChute).clamp(0.0, 1.0);
    final progressoPiso = (perguntasFeitas / _perguntasMinimas).clamp(0.0, 1.0);
    return (confianca * progressoPiso).toDouble();
  }

  bool get deveChutar {
    if (_qualquerDisponivel() == null) return true;
    if (perguntasFeitas < _perguntasMinimas) return false;
    if (gapLider >= gapParaChute) return true;
    if (_selecionar(emJogo, aleatorio: false) == null) return true;
    return false;
  }
}
