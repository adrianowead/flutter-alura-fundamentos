import 'package:bytebank/Editor.dart';
import 'package:flutter/material.dart';

import 'transferencia.dart';

class FormularioTransferencias extends StatelessWidget {
  final TextEditingController _ctrlCampoNumeroConta = TextEditingController();
  final TextEditingController _ctrlCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(children: <Widget>[
        Editor(
            ctrl: this._ctrlCampoNumeroConta,
            rotulo: 'Número da conta',
            dica: '0000'),
        Editor(
            ctrl: this._ctrlCampoValor,
            rotulo: 'Valor',
            dica: '0.00',
            icon: Icons.monetization_on),
        RaisedButton(
          child: Text('Confirmar'),
          onPressed: () => this._criaTransferencia(context),
        )
      ]),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(this._ctrlCampoNumeroConta.text);
    final double valor = double.tryParse(this._ctrlCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada =
          Transferecia(valor: valor, conta: numeroConta);

      Navigator.pop(context, transferenciaCriada);
    }
  }
}
