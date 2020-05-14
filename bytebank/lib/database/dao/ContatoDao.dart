// retorna o id (Int) do registro inserido
import 'package:bytebank/models/ItemContato.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bytebank/database/Contato.dart';

class ContatoDao extends Contato {
  static const String _tableName = 'contato';
  static const String _fieldId = 'id';
  static const String _fieldNome = 'nome';
  static const String _fieldConta = 'conta';

  static const String tableSql = "CREATE TABLE $_tableName("
      "$_fieldId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
      "$_fieldNome VARCHAR(200), "
      "$_fieldConta INTEGER"
      ")";

  Future<int> save(ItemContato contato) async {
    final Database db = await this.getDatabase();

    Map<String, dynamic> contactMap = this._toMap(contato);

    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(ItemContato contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_fieldNome] = contato.nome;
    contactMap[_fieldConta] = contato.conta;
    return contactMap;
  }

  // retorna todos os contatos
  Future<List<ItemContato>> findAll() async {
    final Database db = await this.getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableName); // busca todos os dados da tabela informada

    List<ItemContato> contatos = this._toList(result);

    return contatos;
  }

  List<ItemContato> _toList(List<Map<String, dynamic>> result) {
    final List<ItemContato> contatos = List();

    for (Map<String, dynamic> row in result) {
      contatos.add(new ItemContato(
        id: row[_fieldId],
        nome: row[_fieldNome],
        conta: row[_fieldConta],
      ));
    }
    return contatos;
  }

  Future<int> delete(int id) async {
    final Database db = await this.getDatabase();

    return db.delete(_tableName, where: '$_fieldId = ?', whereArgs: [id]);
  }
}
