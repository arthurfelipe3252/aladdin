enum Resposta {
  sim('Sim', 2),
  provavelmenteSim('Provavelmente sim', 1),
  naoSei('Não sei', 0),
  provavelmenteNao('Provavelmente não', -1),
  nao('Não', -2);

  const Resposta(this.label, this.valor);

  final String label;
  final int valor;
}
