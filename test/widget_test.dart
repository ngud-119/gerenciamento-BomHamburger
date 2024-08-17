// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bomhamburguer/main.dart';

void main() {
  testWidgets('Verifica se a tela inicial carrega', (WidgetTester tester) async {
    // Constrói o app e exibe um frame.
    await tester.pumpWidget(MyApp());

    // Verifica se a tela inicial contém o texto "Sandwiches & Extras".
    expect(find.text('Sandwiches & Extras'), findsOneWidget);
  });
}
