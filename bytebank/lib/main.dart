import 'package:bytebank/listaTransferencias.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Tranferências')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(
          Icons.add
        ),
      ),
      body: ListaTransferencias(),
    ),
  ),
);