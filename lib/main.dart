import 'package:flutter/material.dart';

import 'data/repositories/jogo_repository.dart';
import 'data/services/dados_service.dart';
import 'ui/core/tema.dart';
import 'ui/home/home_view.dart';

void main() {
  runApp(BionatorApp());
}

class BionatorApp extends StatelessWidget {
  BionatorApp({super.key}) : repository = JogoRepository(DadosService());

  final JogoRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIONATOR',
      debugShowCheckedModeBanner: false,
      theme: BionatorTema.tema(),
      home: HomeView(repository: repository),
    );
  }
}
