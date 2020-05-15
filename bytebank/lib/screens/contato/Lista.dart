import 'dart:async';

import 'package:bytebank/database/dao/ContatoDao.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/screens/contato/Formulario.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  final ContatoDao _contatoDao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
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
                  return Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red[700],
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ItemContato(
                      nome: contato.nome,
                      conta: contato.conta,
                    ),
                    onDismissed: (_) => this._contatoDao.delete(contato.id),
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

          future.then((value) => (context as Element).reassemble());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  FutureOr<List<ItemContato>> _carregaBancoDados() {
    final List<ItemContato> listaContatos = List();

    return this._contatoDao.findAll().then((lista) {
      listaContatos.addAll(lista);

      return listaContatos;
    });
  }
}
