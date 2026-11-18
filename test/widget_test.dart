import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vozcidadao/main.dart';

void main() {
  testWidgets('apresenta a identidade e permite acessar o aplicativo', (
    tester,
  ) async {
    await tester.pumpWidget(const VozCidadaApp());
    expect(find.text('VozCidadã'), findsOneWidget);
    expect(find.textContaining('Sem cadastro.'), findsOneWidget);
    final button = find.widgetWithText(FilledButton, 'Acessar o aplicativo');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('Bem-vindo à comunidade'), findsOneWidget);
  });
}
