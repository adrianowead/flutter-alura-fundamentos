import 'dart:async';

import 'package:bytebank/components/CarregandoSpinner.dart';
import 'package:bytebank/components/ResponseDialog.dart';
import 'package:bytebank/components/SemConteudo.dart';
import 'package:bytebank/components/TransferenciaAuthDialog.dart';
import 'package:bytebank/database/dao/ContatoDao.dart';
import 'package:bytebank/http/webClients/TransacaoWebClient.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/screens/contato/Formulario.dart';
import 'package:bytebank/screens/transferencias/Formulario.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  final ContatoDao _contatoDao = ContatoDao();
  final TransacaoWebClient _webClient = TransacaoWebClient();

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
              return CarregandoSpinner(
                message: "Carregando contatos...",
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<ItemContato> contatos = snapshot.data;

                if (contatos.isNotEmpty) {
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
                          onClick: () {
                            final resp = Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return FormularioTransferencias(
                                  contato: contato,
                                );
                              }),
                            );

                            resp.then((transferencia) {
                              showDialog(
                                context: context,
                                builder: (contextAuth) {
                                  return TransferenciaAuthDialog(
                                    onConfirm: (String passwd) {
                                      this
                                          ._webClient
                                          .save(transferencia, passwd)
                                          .then((salvo) {
                                        if (salvo != null) {
                                          showDialog(
                                            context: context,
                                            builder: (contextWarning) {
                                              return SuccessDialog(
                                                message:
                                                    "Transação salva online com sucesso!",
                                              );
                                            },
                                          ).then(
                                            (value) => Navigator.pop(context),
                                          );
                                        }
                                      }).catchError(
                                        (e) {
                                          showDialog(
                                            context: context,
                                            builder: (contextWarning) {
                                              return ErrorDialog(
                                                message: e.message,
                                              );
                                            },
                                          );
                                        },
                                        test: (e) => e is Exception,
                                      );
                                    },
                                  );
                                },
                              );
                            });
                          },
                        ),
                        onDismissed: (_) => this._contatoDao.delete(contato.id),
                      );
                    },
                    itemCount: contatos.length,
                  );
                }
              }

              break;
          }

          return SemConteudo(
            message: "Não há contatdos!",
          );
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
