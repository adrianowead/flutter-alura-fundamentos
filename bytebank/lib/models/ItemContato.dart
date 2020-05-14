import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemContato extends StatelessWidget {
  final int id;
  final String nome;
  final int conta;

  const ItemContato({Key key, this.id = 0, this.nome, this.conta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          this.nome,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          this.conta.toString(),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
