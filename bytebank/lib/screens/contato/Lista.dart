import 'dart:async';

import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/screens/contato/Formulario.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<ItemContato>>(
        initialData: List(),
        future: this._carregaBancoDados(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Carregando..."),
                      ),
                    ]),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<ItemContato> contatos = snapshot.data;

              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final contato = contatos[index];
                  return ItemContato(
                    nome: contato.nome,
                    conta: contato.conta,
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }

          return Text("Conteúdo não encontrado");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<ItemContato> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioContato(),
            ),
          );

          future.then(
            (ItemContato contatoRecebido) =>
                this._atualiza(context, contatoRecebido),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(BuildContext context, ItemContato contatoRecebido) {
    if (contatoRecebido != null) {
      final Contato contatoModel = new Contato();

      contatoModel.save(contatoRecebido).then((value) {
        // forçando um reload para StatelessWidget
        (context as Element).reassemble();
      });
    }
  }

  FutureOr<List<ItemContato>> _carregaBancoDados() {
    final Contato contatoModel = new Contato();
    final List<ItemContato> listaContatos = List();

    return contatoModel.findAll().then((lista) {
      listaContatos.addAll(lista);

      return listaContatos;
    });
  }
}
