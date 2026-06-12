import 'package:flutter/material.dart';

import '../../core/tema.dart';

class PensandoView extends StatelessWidget {
  const PensandoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🧞', style: TextStyle(fontSize: 80)),
          SizedBox(height: 28),
          CircularProgressIndicator(color: AladdinTema.destaqueClaro),
          SizedBox(height: 28),
          Text('Deixa eu pensar…', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
