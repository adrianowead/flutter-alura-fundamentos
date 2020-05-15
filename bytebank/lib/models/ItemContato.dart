import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemContato extends StatelessWidget {
  final int id;
  final String nome;
  final int conta;

  final Function onClick;

  const ItemContato(
      {Key key,
      this.id = 0,
      this.nome,
      this.conta,
      @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: this.onClick,
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

  ItemContato.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['name'],
        conta = json['accountNumber'],
        onClick = null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': nome, 'accountNumber': conta};
}
