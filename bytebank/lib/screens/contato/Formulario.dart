import 'package:bytebank/components/Editor.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  final TextEditingController _ctrlCampoNome = TextEditingController();
  final TextEditingController _ctrlCampoConta = TextEditingController();

  @override
  _FormularioContatoState createState() => _FormularioContatoState();

  void _criaContato(BuildContext context) {
    final String nome = this._ctrlCampoNome.text;
    final int conta = int.tryParse(this._ctrlCampoConta.text);

    if (nome != null && conta != null) {
      final contatoCriado = ItemContato(
        nome: nome,
        conta: conta,
      );

      Navigator.pop(context, contatoCriado);
    }
  }
}

class _FormularioContatoState extends State<FormularioContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Contato'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Editor(
            ctrl: widget._ctrlCampoNome,
            rotulo: 'Nome',
            dica: 'Fulano',
            tipo: TextInputType.text,
          ),
          Editor(
            ctrl: widget._ctrlCampoConta,
            rotulo: 'Conta',
            dica: '0000',
          ),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () => widget._criaContato(context),
          )
        ]),
      ),
    );
  }
}
