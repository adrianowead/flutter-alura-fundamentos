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

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(Transferencia transferencia) async {
    final Client client = this.geClient();

    print(transferencia.toJson());

    final Response response = await client.post(
      this._baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: jsonEncode(transferencia.toJson()),
    );

    return Transferencia.fromJson(jsonDecode(response.body));
  }
}
