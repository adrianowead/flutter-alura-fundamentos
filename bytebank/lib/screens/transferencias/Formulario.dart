import 'package:bytebank/components/Editor.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/models/Transferencia.dart';

class FormularioTransferencias extends StatefulWidget {
  final TextEditingController _ctrlCampoNumeroConta = TextEditingController();
  final TextEditingController _ctrlCampoValor = TextEditingController();

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(this._ctrlCampoNumeroConta.text);
    final double valor = double.tryParse(this._ctrlCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada =
          Transferencia(valor: valor, conta: numeroConta);

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
          Editor(
              ctrl: widget._ctrlCampoNumeroConta,
              rotulo: 'Número da conta',
              dica: '0000'),
          Editor(
              ctrl: widget._ctrlCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icon: Icons.monetization_on),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () => widget._criaTransferencia(context),
          )
        ]),
      ),
    );
  }
}
