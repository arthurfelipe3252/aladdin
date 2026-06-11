import 'package:flutter/material.dart';

class BionatorTema {
  const BionatorTema._();

  static const Color fundoTopo = Color(0xFF2A1A4A);
  static const Color fundoBase = Color(0xFF120B26);
  static const Color destaque = Color(0xFF9C6BFF);
  static const Color destaqueClaro = Color(0xFFC9A8FF);

  static const LinearGradient fundoGradiente = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [fundoTopo, fundoBase],
  );

  static ThemeData tema() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: fundoBase,
      colorScheme: ColorScheme.fromSeed(
        seedColor: destaque,
        brightness: Brightness.dark,
      ),
    );
  }
}
