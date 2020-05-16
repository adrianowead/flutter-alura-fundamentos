import 'dart:async';
import 'dart:io';

import 'package:bytebank/components/Editor.dart';
import 'package:bytebank/components/ResponseDialog.dart';
import 'package:bytebank/components/TransferenciaAuthDialog.dart';
import 'package:bytebank/http/webClients/TransacaoWebClient.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/models/Transferencia.dart';
import 'package:http_interceptor/models/http_interceptor_exception.dart';
import 'package:uuid/uuid.dart';

class FormularioTransferencias extends StatefulWidget {
  final TextEditingController _ctrlCampoValor = TextEditingController();
  final ItemContato contato;
  final TransacaoWebClient _webClient = TransacaoWebClient();
  final String transacaoId = Uuid().v4();

  FormularioTransferencias({Key key, this.contato}) : super(key: key);

  void _criaTransferencia(BuildContext context) {
    final double valor = double.tryParse(this._ctrlCampoValor.text);

    if (valor != null) {
      final transferenciaCriada = Transferencia(
        id: this.transacaoId,
        valor: valor,
        contato: this.contato,
      );

      showDialog(
        context: context,
        builder: (contextAuth) {
          return TransferenciaAuthDialog(
            onConfirm: (String passwd) async {
              dynamic salvo = await _savlarOnline(
                transferenciaCriada,
                passwd,
                context,
              );

              if (salvo != null) {
                await showDialog(
                  context: context,
                  builder: (contextWarning) {
                    return SuccessDialog(
                      message: "Transação salva online com sucesso!",
                    );
                  },
                );

                Navigator.pop(context);
              }
            },
          );
        },
      );
    }
  }

  Future _savlarOnline(
      Transferencia transferencia, String passwd, BuildContext context) async {
    dynamic salvo = await this
        ._webClient
        .save(transferencia, passwd)
        .catchError(
          (e) => this
              ._showFailureMessage(context, 'Sem internet, tempo expirado.'),
          test: (e) => e is TimeoutException,
        )
        .catchError(
          (e) => this._showFailureMessage(context, 'Sem conexão de internet.'),
          test: (e) =>
              e is SocketException ||
              e is HttpInterceptorException ||
              e is WebSocketException,
        )
        .catchError(
          (e) => this._showFailureMessage(context, e.message),
          test: (e) => e is HttpException,
        )
        .catchError(
          (e) =>
              this._showFailureMessage(context, 'Ocorreu um erro inesperado.'),
        );
    return salvo;
  }

  void _showFailureMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (contextWarning) {
        return ErrorDialog(
          message: message,
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciasState();
  }
}

class FormularioTransferenciasState extends State<FormularioTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 1.0),
            child: Container(
              child: Text(
                widget.contato.nome,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              width: double.maxFinite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
            child: Container(
              child: Text(
                widget.contato.conta.toString(),
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              width: double.maxFinite,
            ),
          ),
          Editor(
              ctrl: widget._ctrlCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icon: Icons.monetization_on),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () {
              widget._criaTransferencia(context);
            },
          )
        ]),
      ),
    );
  }
}
