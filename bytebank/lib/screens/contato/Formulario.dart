import 'package:bytebank/components/Editor.dart';
import 'package:bytebank/database/dao/ContatoDao.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  final ContatoDao _contatoDao = ContatoDao();

  final TextEditingController _ctrlCampoNome = TextEditingController();
  final TextEditingController _ctrlCampoConta = TextEditingController();

  @override
  _FormularioContatoState createState() => _FormularioContatoState();

  void _criaContato(BuildContext context) async {
    final String nome = this._ctrlCampoNome.text;
    final int conta = int.tryParse(this._ctrlCampoConta.text);

    if (nome != null && conta != null) {
      final contatoCriado = ItemContato(
        nome: nome,
        conta: conta,
      );

      await this._contatoDao.save(contatoCriado);

      Navigator.pop(context);
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
        child: Column(
          children: <Widget>[
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Confirmar'),
                  onPressed: () => widget._criaContato(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
