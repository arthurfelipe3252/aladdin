// Testes da lógica pura do BIONATOR (camada domain, sem Flutter).

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:akinator_estudantil/data/repositories/jogo_repository.dart';
import 'package:akinator_estudantil/data/services/dados_service.dart';
import 'package:akinator_estudantil/domain/bionator_engine.dart';
import 'package:akinator_estudantil/domain/models/resposta.dart';

void main() {
  final repository = JogoRepository(DadosService());
  final professores = repository.professores();
  final perguntas = repository.perguntas();

  BionatorEngine novoEngine() => BionatorEngine(
    professores: professores,
    perguntas: perguntas,
    random: Random(7),
  )..iniciar();

  group('BionatorEngine', () {
    test('crava cada um dos 15 professores respondendo conforme o perfil', () {
      for (final alvo in professores) {
        final engine = novoEngine();
        var seguranca = 0;
        while (!engine.deveChutar && seguranca < 100) {
          final pergunta = engine.proximaPergunta();
          expect(pergunta, isNotNull);
          final resposta =
              alvo.traco(pergunta!.id) == 1 ? Resposta.sim : Resposta.nao;
          engine.responder(pergunta, resposta);
          seguranca++;
        }
        expect(
          engine.lider.id,
          alvo.id,
          reason: 'Deveria cravar ${alvo.nome}',
        );
        expect(
          engine.perguntasFeitas,
          greaterThanOrEqualTo(4),
          reason: 'Deve respeitar o piso de 4 perguntas',
        );
      }
    });

    test('respeita o piso de 4 perguntas antes de arriscar', () {
      final engine = novoEngine();
      for (var i = 0; i < 3; i++) {
        expect(engine.deveChutar, isFalse);
        engine.responder(engine.proximaPergunta()!, Resposta.sim);
      }
    });

    test('grupo "cidade": responder Sim a uma pula as outras duas', () {
      final engine = novoEngine();
      final moraMcr = perguntas.firstWhere((p) => p.id == 'mora_mcr');
      engine.responder(moraMcr, Resposta.sim);

      var seguranca = 0;
      while (!engine.deveChutar && seguranca < 100) {
        final pergunta = engine.proximaPergunta();
        if (pergunta == null) break;
        expect(pergunta.id, isNot('mora_cascavel'));
        expect(pergunta.id, isNot('mora_toledo'));
        engine.responder(pergunta, Resposta.naoSei);
        seguranca++;
      }
    });

    test('continuar após erro descarta o palpite e exige mais perguntas', () {
      final alvo = professores.firstWhere((p) => p.id == 'renato');
      final engine = novoEngine();
      var seguranca = 0;
      while (!engine.deveChutar && seguranca < 100) {
        final pergunta = engine.proximaPergunta()!;
        engine.responder(
          pergunta,
          alvo.traco(pergunta.id) == 1 ? Resposta.sim : Resposta.nao,
        );
        seguranca++;
      }
      final palpite = engine.lider;

      engine.continuar(palpite);

      // O professor descartado não pode mais ser o líder...
      expect(engine.lider.id, isNot(palpite.id));
      // ...e o jogo não deve arriscar de imediato (exige +3 perguntas).
      expect(engine.deveChutar, isFalse);
    });

    test('escalaVisual: empate=1, cresce sem teto, eliminado=0', () {
      final engine = novoEngine();
      // início: todos com escala 1 (0 pontos)
      for (final p in professores) {
        expect(engine.escalaVisual(p), 1.0);
      }
      // pontua em direção a um alvo
      final alvo = professores.firstWhere((p) => p.id == 'renato');
      for (var n = 0; n < 6; n++) {
        final pergunta = engine.proximaPergunta()!;
        engine.responder(
          pergunta,
          alvo.traco(pergunta.id) == 1 ? Resposta.sim : Resposta.nao,
        );
      }
      // o líder cresceu acima de 1 (sem teto) e fica maior que o último
      expect(engine.escalaVisual(engine.lider) > 1.0, isTrue);
      expect(
        engine.escalaVisual(engine.ranking.last) <
            engine.escalaVisual(engine.lider),
        isTrue,
      );
      for (final p in professores) {
        expect(engine.escalaVisual(p) >= 0.0, isTrue);
      }
      // eliminado some (escala 0)
      final eliminado = engine.lider;
      engine.continuar(eliminado);
      expect(engine.escalaVisual(eliminado), 0.0);
    });

    test('proximidadeChute: 0 no início e 1 quando vai chutar', () {
      final engine = novoEngine();
      expect(engine.proximidadeChute(), 0.0);
      final alvo = professores.firstWhere((p) => p.id == 'renato');
      var seguranca = 0;
      while (!engine.deveChutar && seguranca < 100) {
        final pergunta = engine.proximaPergunta()!;
        engine.responder(
          pergunta,
          alvo.traco(pergunta.id) == 1 ? Resposta.sim : Resposta.nao,
        );
        seguranca++;
      }
      expect(engine.proximidadeChute(), 1.0);
    });
  });
}
