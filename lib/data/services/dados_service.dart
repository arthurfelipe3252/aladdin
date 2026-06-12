import '../../domain/models/pergunta.dart';
import '../../domain/models/professor.dart';

class DadosService {
  List<Pergunta> perguntas() => const [
    Pergunta(id: 'cabelo_curto', texto: 'O professor tem cabelo curto?'),
    Pergunta(
      id: 'camisa_social',
      texto: 'Costuma dar aula de camisa (social) em vez de camiseta?',
    ),
    Pergunta(id: 'oculos', texto: 'O professor usa óculos?'),
    Pergunta(id: 'tatuagem', texto: 'O professor tem tatuagem?'),
    Pergunta(id: 'loiro', texto: 'O professor tem cabelo loiro?'),
    Pergunta(id: 'barba', texto: 'O professor tem barba?'),
    Pergunta(
      id: 'colorido',
      texto: 'O professor tem (ou já teve) cabelo colorido?',
    ),
    Pergunta(
      id: 'mora_mcr',
      texto: 'O professor mora em Marechal Cândido Rondon?',
      grupoExclusao: 'cidade',
    ),
    Pergunta(
      id: 'mora_cascavel',
      texto: 'O professor mora em Cascavel?',
      grupoExclusao: 'cidade',
    ),
    Pergunta(
      id: 'mora_toledo',
      texto: 'O professor mora em Toledo?',
      grupoExclusao: 'cidade',
    ),
    Pergunta(
      id: 'teoria_gestao',
      texto: 'A disciplina dele envolve muita teoria/gestão?',
    ),
    Pergunta(
      id: 'semestre_atual',
      texto: 'O professor dá aula no semestre atual?',
    ),
    Pergunta(
      id: 'programacao',
      texto:
          'O professor trabalha principalmente com programação/desenvolvimento?',
    ),
    Pergunta(
      id: 'codigo_ao_vivo',
      texto: 'O professor mostra código ao vivo nas aulas?',
    ),
    Pergunta(
      id: 'informal',
      texto: 'O professor fala de um jeito informal/descontraído?',
    ),
    Pergunta(
      id: 'libera_cedo',
      texto: 'O professor costuma liberar a turma mais cedo?',
    ),
    Pergunta(
      id: 'projeto_integrador',
      texto: 'O professor foi professor da matéria Projeto Integrador?',
    ),
    Pergunta(
      id: 'escrevem_codigo',
      texto: 'Já deu alguma disciplina onde os alunos escrevem código?',
    ),
    Pergunta(
      id: 'uma_materia',
      texto: 'O professor deu apenas uma matéria até o momento?',
    ),
    Pergunta(
      id: 'nao_da_mais_aula',
      texto: 'É um professor que não dá mais aula na faculdade?',
    ),
    Pergunta(id: 'github', texto: 'O professor deu aula sobre GitHub?'),
    Pergunta(
      id: 'prati',
      texto: 'O professor trabalha (ou trabalhou) na Prati Donaduzzi?',
    ),
    Pergunta(
      id: 'coordenador_es',
      texto: 'É (ou foi) coordenador(a) do curso de Engenharia de Software?',
    ),
    Pergunta(
      id: 'slides',
      texto: 'O professor usa slides com frequência nas aulas?',
    ),
    Pergunta(
      id: 'exercicio',
      texto: 'O professor passa bastante exercício para fixação?',
    ),
    Pergunta(
      id: 'seminarios',
      texto: 'O professor gosta de dar apresentações/seminários?',
    ),
    Pergunta(
      id: 'projetos',
      texto: 'O professor usa projetos para fixação do conteúdo?',
    ),
  ];

  static const Map<String, Set<String>> _simPorPergunta = {
    'cabelo_curto': {
      'jefferson_speck',
      'jhoni',
      'guilherme_alves',
      'jeferson_vorpagel',
      'andre_dorr',
      'renato',
      'marcel',
      'hiago',
      'alan',
      'fabiano',
    },
    'camisa_social': {'marcos_guido', 'alan', 'renato'},
    'oculos': {'fabiane', 'leticia', 'jefferson_speck', 'jeferson_vorpagel'},
    'tatuagem': {
      'jefferson_speck',
      'fabiane',
      'jeferson_vorpagel',
      'guilherme_alves',
      'leticia',
      'renato',
      'marcel',
      'hiago',
      'fabiano',
    },
    'loiro': {'fabiane', 'dani', 'leticia', 'alan'},
    'barba': {
      'fabiano',
      'hiago',
      'marcel',
      'andre_dorr',
      'jeferson_vorpagel',
      'willian',
      'jefferson_speck',
    },
    'colorido': {'leticia', 'jefferson_speck'},
    'mora_mcr': {'jhoni', 'marcel', 'jefferson_speck'},
    'mora_cascavel': {'marcos_guido', 'fabiano'},
    'mora_toledo': {
      'fabiane',
      'willian',
      'guilherme_alves',
      'leticia',
      'andre_dorr',
      'renato',
      'dani',
      'alan',
      'jeferson_vorpagel',
    },
    'teoria_gestao': {'leticia', 'marcel', 'hiago', 'dani', 'fabiano'},
    'semestre_atual': {
      'jefferson_speck',
      'jeferson_vorpagel',
      'willian',
      'guilherme_alves',
      'marcos_guido',
    },
    'programacao': {'jefferson_speck', 'jhoni', 'willian', 'guilherme_alves'},
    'codigo_ao_vivo': {'jefferson_speck', 'jhoni', 'guilherme_alves', 'renato'},
    'informal': {
      'jeferson_vorpagel',
      'jefferson_speck',
      'jhoni',
      'willian',
      'fabiane',
      'guilherme_alves',
      'leticia',
      'andre_dorr',
      'hiago',
      'fabiano',
    },
    'libera_cedo': {
      'jefferson_speck',
      'willian',
      'guilherme_alves',
      'leticia',
      'jeferson_vorpagel',
      'fabiano',
    },
    'projeto_integrador': {'renato', 'willian', 'andre_dorr', 'alan'},
    'escrevem_codigo': {
      'renato',
      'marcos_guido',
      'jhoni',
      'guilherme_alves',
      'jefferson_speck',
      'willian',
    },
    'uma_materia': {
      'alan',
      'fabiano',
      'marcel',
      'hiago',
      'dani',
      'fabiane',
      'jeferson_vorpagel',
    },
    'nao_da_mais_aula': {'renato', 'fabiano', 'alan', 'hiago'},
    'github': {'jhoni', 'leticia'},
    'prati': {'renato', 'hiago', 'alan', 'dani'},
    'coordenador_es': {'dani', 'fabiane'},
    'slides': {
      'guilherme_alves',
      'marcos_guido',
      'leticia',
      'marcel',
      'hiago',
      'dani',
    },
    'exercicio': {'renato', 'willian', 'jefferson_speck', 'marcel'},
    'seminarios': {'marcos_guido', 'marcel'},
    'projetos': {'fabiano', 'jefferson_speck', 'jhoni', 'renato'},
  };

  static const Map<String, String> _nomes = {
    'fabiane': 'Fabiane',
    'jefferson_speck': 'Jefferson Speck',
    'jhoni': 'Jhoni',
    'willian': 'Willian',
    'guilherme_alves': 'Guilherme Alves',
    'marcos_guido': 'Marcos Guido',
    'leticia': 'Letícia',
    'jeferson_vorpagel': 'Jeferson Vorpagel',
    'andre_dorr': 'André Dorr',
    'renato': 'Renato',
    'marcel': 'Marcel',
    'hiago': 'Hiago',
    'dani': 'Dani',
    'alan': 'Alan',
    'fabiano': 'Fabiano',
  };

  List<Professor> professores() {
    final perguntasIds = perguntas().map((q) => q.id).toList();
    return _nomes.entries.map((entrada) {
      final id = entrada.key;
      final tracos = <String, int>{
        for (final perguntaId in perguntasIds)
          perguntaId: (_simPorPergunta[perguntaId]!.contains(id) ? 1 : -1),
      };
      return Professor(
        id: id,
        nome: entrada.value,
        foto: 'assets/professores/$id.jpg',
        tracos: tracos,
      );
    }).toList();
  }
}
