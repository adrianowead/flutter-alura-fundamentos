import 'dart:async';
import 'package:bytebank/database/dao/ContatoDao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Contato {
  final int id;
  final String nome;
  final int conta;

  Contato({this.id, this.nome, this.conta});

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'bytebank_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(ContatoDao.tableSql);
      },
      version: 1,
    );
  }
}
