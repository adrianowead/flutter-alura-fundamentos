import 'package:bytebank/components/Editor.dart';
import 'package:bytebank/components/TransferenciaAuthDialog.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/models/Transferencia.dart';

class FormularioTransferencias extends StatefulWidget {
  final TextEditingController _ctrlCampoValor = TextEditingController();
  final ItemContato contato;

  FormularioTransferencias({Key key, this.contato}) : super(key: key);

  void _criaTransferencia(BuildContext context) {
    final double valor = double.tryParse(this._ctrlCampoValor.text);

    if (valor != null) {
      final transferenciaCriada =
          Transferencia(valor: valor, contato: this.contato);

      Navigator.pop(context, transferenciaCriada);
    }
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
