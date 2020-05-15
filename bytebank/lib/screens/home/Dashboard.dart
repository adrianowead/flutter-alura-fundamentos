import 'package:bytebank/screens/contato/Lista.dart';
import 'package:bytebank/screens/home/ItemDashboard.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/bytebank_logo.png'),
        ),
        Row(
          children: <Widget>[
            ItemDashboard(
              nome: 'Transfer',
              icone: Icons.monetization_on,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaContatos(),
                  ),
                );
              },
            ),
            ItemDashboard(
              nome: 'Transaction Feed',
              icone: Icons.description,
              callback: () {},
            ),
          ],
        ),
      ],
    );
  }
}
