import 'dart:convert';

import 'package:bytebank/http/WebClient.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';

class TransacaoWebClient extends WebClient {
  final String _baseUrl = 'http://192.168.1.7:8080/transactions';

  Future<List<Transferencia>> findAll() async {
    final Client client = this.geClient();

    final Response response =
        await client.get(this._baseUrl).timeout(Duration(seconds: 5));

    final List<dynamic> transacaoJson = jsonDecode(response.body);
    final List<Transferencia> transferencias = _toTransactions(transacaoJson);

    return transferencias;
  }

  Future<Transferencia> save(Transferencia transferencia) async {
    final Client client = this.geClient();
    final String transferenciaJson = jsonEncode(transferencia.toJson());

    final Response response = await client.post(
      this._baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transferenciaJson,
    );

    return _toTransaction(response);
  }

  Transferencia _toTransaction(Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);

    return Transferencia.fromJson(json);
  }

  List<Transferencia> _toTransactions(List transacaoJson) {
    final List<Transferencia> transferencias = List();

    for (Map<String, dynamic> item in transacaoJson) {
      transferencias.add(Transferencia.fromJson(item));
    }
    return transferencias;
  }
}
