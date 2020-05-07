import 'package:bytebank/FormularioTransferencias.dart';
import 'package:bytebank/itemTransferencia.dart';
import 'package:bytebank/transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferecia> _transferencias =
      List(); // inicializando com uma lista vazia

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tranferências')),
      // o listview builder, suporta atualizações dinâmicas
      // diferente do listview simples
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (BuildContext context, int index) {
          final transf = widget._transferencias[index];
          return ItemTransferencia(transf);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferecia> future = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormularioTransferencias()));

          future.then((Transferecia transferenciaRecebida) {
            if (transferenciaRecebida != null)
              widget._transferencias.add(transferenciaRecebida);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
