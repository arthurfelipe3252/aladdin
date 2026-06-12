import 'package:flutter/material.dart';

import 'data/repositories/jogo_repository.dart';
import 'data/services/dados_service.dart';
import 'ui/core/tema.dart';
import 'ui/home/home_view.dart';

void main() {
  runApp(AladdinApp());
}

class AladdinApp extends StatelessWidget {
  AladdinApp({super.key}) : repository = JogoRepository(DadosService());

  final JogoRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aladdin',
      debugShowCheckedModeBanner: false,
      theme: AladdinTema.tema(),
      home: HomeView(repository: repository),
    );
  }
}
