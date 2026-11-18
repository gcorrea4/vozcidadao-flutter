import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vozcidadao/main.dart';

Future<void> enterApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const VozCidadaApp());
  final enter = find.text('Acessar o aplicativo');
  await tester.ensureVisible(enter);
  await tester.tap(enter);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('busca de serviços filtra e abre detalhes por parâmetro', (
    tester,
  ) async {
    await enterApp(tester);
    await tester.tap(find.text('Serviços'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('service-search')),
      'vacinacao',
    );
    await tester.pumpAndSettle();
    expect(find.text('1 orientação encontrada'), findsOneWidget);
    await tester.tap(find.text('Informações sobre vacinação'));
    await tester.pumpAndSettle();
    expect(find.text('Por onde começar'), findsOneWidget);
    expect(
      find.text('Separe seu histórico ou carteira de vacinação, se tiver.'),
      findsOneWidget,
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('service-search')),
      'inexistente',
    );
    await tester.pumpAndSettle();
    expect(find.text('Nenhum serviço encontrado'), findsOneWidget);
  });

  testWidgets('apoio nos detalhes atualiza a lista e impede segundo voto', (
    tester,
  ) async {
    await enterApp(tester);
    await tester.tap(find.text('Propostas'));
    await tester.pumpAndSettle();
    final details = find.text('Ver detalhes').first;
    await tester.ensureVisible(details);
    await tester.tap(details);
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('detail-support'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('129 apoios'), findsOneWidget);
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('129 apoios'), findsOneWidget);
    expect(
      tester
          .widget<OutlinedButton>(find.byKey(const ValueKey('support-p1')))
          .onPressed,
      isNull,
    );
  });

  testWidgets('valida formulário, cadastra e acompanha nova proposta', (
    tester,
  ) async {
    await enterApp(tester);
    await tester.tap(find.byKey(const ValueKey('dashboard-create')));
    await tester.pumpAndSettle();
    final save = find.byKey(const ValueKey('save-proposal'));
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(find.text('Selecione uma categoria.'), findsOneWidget);
    expect(find.text('Preencha o campo título.'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('proposal-title')));
    await tester.enterText(
      find.byKey(const ValueKey('proposal-title')),
      'Calçada acessível para todos',
    );
    final category = find.byKey(const ValueKey('proposal-category'));
    await tester.ensureVisible(category);
    await tester.tap(category);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Infraestrutura').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('proposal-neighborhood')),
    );
    await tester.enterText(
      find.byKey(const ValueKey('proposal-neighborhood')),
      'Jardim Ângela',
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('proposal-description')),
    );
    await tester.enterText(
      find.byKey(const ValueKey('proposal-description')),
      'Proponho mapear trechos da calçada e priorizar melhorias de acessibilidade para os moradores.',
    );
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(find.text('Calçada acessível para todos'), findsOneWidget);
    expect(find.text('Sua proposta'), findsOneWidget);
    await tester.tap(find.text('Acompanhar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minhas propostas'));
    await tester.pumpAndSettle();
    expect(find.text('Calçada acessível para todos'), findsOneWidget);
    expect(find.text('Mais luz no caminho de casa'), findsNothing);
  });

  testWidgets('boas-vindas suporta tela pequena com texto ampliado', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.5)),
          child: child!,
        ),
        home: const VozCidadaApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Acessar o aplicativo'));
    expect(find.text('Acessar o aplicativo'), findsOneWidget);
  });
}
