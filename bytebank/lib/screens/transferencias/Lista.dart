import 'package:bytebank/components/CarregandoSpinner.dart';
import 'package:bytebank/components/SemConteudo.dart';
import 'package:bytebank/http/WebclientTransacoes.dart';
import 'package:bytebank/models/ItemTransferencia.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tranferências')),
      body: FutureBuilder<List<Transferencia>>(
        future: WebclientTransacoes().findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CarregandoSpinner(
                message: "Carregando transferências...",
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                final List<Transferencia> transferencias = snapshot.data;

                if (transferencias.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transferencias.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transf = transferencias[index];
                      return ItemTransferencia(transf);
                    },
                  );
                }
              }

              break;
          }

          return SemConteudo(message: "Não há transações!",);
        },
      ),
    );
  }
}
