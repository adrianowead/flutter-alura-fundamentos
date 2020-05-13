import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/screens/contato/Formulario.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  final List<ItemContato> _contatos =
      List(); // inicializando com uma lista vazia

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  @override
  void initState() {
    this._carregaBancoDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final contato = widget._contatos[index];
          return ItemContato(
            nome: contato.nome,
            conta: contato.conta,
          );
        },
        itemCount: widget._contatos.length,
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
            (ItemContato contatoRecebido) => this._atualiza(contatoRecebido),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(ItemContato contatoRecebido) {
    if (contatoRecebido != null) {
      final Contato contatoModel = new Contato();

      contatoModel.save(contatoRecebido).then((insertId) {
        this._carregaBancoDados();
      });
    }
  }

  void _carregaBancoDados() {
    final Contato contatoModel = new Contato();

    contatoModel.findAll().then((list) {
      // o set state, força a execução do build, e assim garantindo a atualização da tela com os dados
      setState(() {
        widget._contatos.addAll(list);
      });
    });
  }
}
