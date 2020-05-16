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

  testWidgets('Deve apresentar os botoes abaixo quando o Dashboard é aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final feature = find.byType(ItemDashboard);

    expect(feature, findsWidgets);
  });
}
