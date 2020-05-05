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
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: TextField(
            controller: this._ctrlCampoNumeroConta,
            style: TextStyle(fontSize: 24.0),
            keyboardType: TextInputType.phone,
            decoration:
                InputDecoration(labelText: 'Número da conta', hintText: '0000'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: TextField(
            controller: this._ctrlCampoValor,
            style: TextStyle(fontSize: 24.0),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: 'Valor',
                hintText: '0.00',
                icon: Icon(Icons.monetization_on)),
          ),
        ),
        RaisedButton(
          child: Text('Confirmar'),
          onPressed: () async {
            final int numeroConta =
                int.tryParse(this._ctrlCampoNumeroConta.text);
            final double valor = double.tryParse(this._ctrlCampoValor.text);

            if (numeroConta != null && valor != null) {
              final transferenciaCriada =
                  Transferecia(valor: valor, conta: numeroConta);

              // @TODO: Remover este debug
              debugPrint(transferenciaCriada.toString());
            }
          },
        )
      ]),
    );
  }
}
