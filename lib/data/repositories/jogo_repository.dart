import '../../domain/models/pergunta.dart';
import '../../domain/models/professor.dart';
import '../services/dados_service.dart';

class JogoRepository {
  JogoRepository(this._dados);

  final DadosService _dados;

  List<Professor> professores() => _dados.professores();

  List<Pergunta> perguntas() => _dados.perguntas();
}
