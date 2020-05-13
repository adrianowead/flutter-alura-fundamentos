import 'dart:async';
import 'package:bytebank/models/ItemContato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Contato {
  final int id;
  final String nome;
  final int conta;

  Contato({this.id, this.nome, this.conta});

  Future<Database> _createDatabase() {
    return getDatabasesPath().then((dbPath) {
      final String path = join(dbPath, 'bytebank_database.db');

      return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE contato("
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
            "nome VARCHAR(200), "
            "conta INTEGER"
            ")",
          );
        },
        version: 1,
      );
    });
  }

  // retorna o id (Int) do registro inserido
  Future<int> save(ItemContato contato) {
    return this._createDatabase().then((db) {
      final Map<String, dynamic> contactMap = Map();
      contactMap['nome'] = contato.nome;
      contactMap['conta'] = contato.conta;

      return db.insert('contato', contactMap);
    });
  }

  // retorna todos os contatos
  Future<List<ItemContato>> findAll() {
    final Future<List<Map<String, dynamic>>> dados =
        this._createDatabase().then((db) {
      return db.query("contato"); // busca todos os dados da tabela informada
    });

    return dados.then((maps) {
      final List<ItemContato> contatos = List();

      for (Map<String, dynamic> map in maps) {
        contatos.add(new ItemContato(
          id: map['id'],
          nome: map['nome'],
          conta: map['conta'],
        ));
      }

      return contatos;
    });
  }

  Future<int> delete(int id) {
    return this._createDatabase().then((db) {
      return db.delete('contatos', where: 'id = ?', whereArgs: [id]);
    });
  }
}
