import 'dart:convert';

import 'package:bytebank/http/WebClient.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';

class TransacaoWebClient extends WebClient {
  final String _baseUrl = 'http://192.168.1.5:8080/transactions';

  Future<List<Transferencia>> findAll() async {
    final Client client = this.geClient();

    final Response response = await client.get(this._baseUrl);

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(Transferencia transferencia, String passwd) async {
    final Client client = this.geClient();

    final Response response = await client.post(
      this._baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': passwd,
      },
      body: jsonEncode(transferencia.toJson()),
    );

    if (response.statusCode == 200) {
      return Transferencia.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponse[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponse = {
    400: 'Falha ao enviar a transação!',
    401: 'Falha na autenticação!'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
