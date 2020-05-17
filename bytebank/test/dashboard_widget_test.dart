import 'package:bytebank/screens/home/Dashboard.dart';
import 'package:bytebank/screens/home/ItemDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Deve apresentar a imagem principal quando o Dashboard é aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image);

    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Deve apresentar a funcionalidade de transferência quando o Dashboard é aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final featureItem = find.byWidgetPredicate((widget) =>
        itemDashboardMatcher(widget, 'Transferências', Icons.swap_horiz));

    expect(featureItem, findsOneWidget);
  });

  testWidgets(
      'Deve apresentar a funcionalidade de contatos quando o Dashboard é aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final featureItem = find.byWidgetPredicate(
        (widget) => itemDashboardMatcher(widget, 'Pessoas', Icons.people));

    expect(featureItem, findsOneWidget);
  });
}

bool itemDashboardMatcher(Widget widget, String name, IconData icon) {
  if (widget is ItemDashboard) {
    return widget.nome == name && widget.icone == icon;
  }

  return false;
}
