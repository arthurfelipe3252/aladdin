// Teste de fumaça da tela inicial do Aladdin.

import 'package:flutter_test/flutter_test.dart';

import 'package:akinator_estudantil/main.dart';

void main() {
  testWidgets('Tela inicial mostra o nome do app e o botão Começar', (
    tester,
  ) async {
    await tester.pumpWidget(AladdinApp());

    expect(find.text('Aladdin'), findsOneWidget);
    expect(find.text('COMEÇAR'), findsOneWidget);
  });
}
