import 'package:bytebank/BytebankApp.dart';
import 'package:bytebank/screens/contato/Formulario.dart';
import 'package:bytebank/screens/contato/Lista.dart';
import 'package:bytebank/screens/home/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('Deve salvar um contato', (tester) async {
    await tester.pumpWidget(BytebankApp());

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final contatoFeatureItem = find.byWidgetPredicate(
        (widget) => itemDashboardMatcher(widget, 'Pessoas', Icons.people));

    expect(contatoFeatureItem, findsOneWidget);

    await tester.tap(contatoFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ListaContatos);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(FormularioContato);
    expect(contactForm, findsOneWidget);
  });
}
