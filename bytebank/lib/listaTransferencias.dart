import 'package:bytebank/itemTransferencia.dart';
import 'package:bytebank/transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemTransferencia(Transferecia(valor: 100, conta: 1000)),
        ItemTransferencia(Transferecia(valor: 950, conta: 3000)),
        ItemTransferencia(Transferecia(valor: 50, conta: 200)),
      ],
    );
  }
}
