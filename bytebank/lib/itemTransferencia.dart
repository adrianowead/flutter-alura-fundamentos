import 'package:bytebank/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferecia _transferecia;

  const ItemTransferencia(this._transferecia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this._transferecia.valor.toString()),
        subtitle: Text(this._transferecia.conta.toString()),
      ),
    );
  }
}
