import 'package:bytebank/listaTransferencias.dart';
import 'package:flutter/material.dart';

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      home: ListaTransferencias()
    );
  }
}
