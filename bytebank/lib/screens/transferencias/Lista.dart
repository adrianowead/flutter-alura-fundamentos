import 'package:bytebank/screens/transferencias/Formulario.dart';
import 'package:bytebank/models/ItemTransferencia.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias =
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
          final Future<Transferencia> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioTransferencias(),
            ),
          );

          future.then((Transferencia transferenciaRecebida) =>
              this._atualiza(transferenciaRecebida));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      // o set state, força a execução do build, e assim garantindo a atualização da tela com os dados
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}
