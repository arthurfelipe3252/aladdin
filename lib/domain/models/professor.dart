class Professor {
  const Professor({
    required this.id,
    required this.nome,
    required this.foto,
    required this.tracos,
  });

  final String id;
  final String nome;
  final String foto;
  final Map<String, int> tracos;

  int traco(String perguntaId) => tracos[perguntaId] ?? -1;
}
