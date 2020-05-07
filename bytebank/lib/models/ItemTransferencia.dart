import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(this._transferencia.valor.toString()),
        subtitle: Text(this._transferencia.conta.toString()),
      ),
    );
  }
}
