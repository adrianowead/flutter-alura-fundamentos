import 'dart:convert';

import 'package:bytebank/database/Contato.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';

class WebclientTransacoes {
  final String _baseUrl = 'http://192.168.1.7:8080/transactions';

  Future<List<Transferencia>> findAll() async {
    final Client client = this._geClient();

    final Response response =
        await client.get(this._baseUrl).timeout(Duration(seconds: 5));

    final List<dynamic> transacaoJson = jsonDecode(response.body);
    final List<Transferencia> transferencias = List();

    for (Map<String, dynamic> item in transacaoJson) {
      final Map<String, dynamic> contatoJson = item['contact'];

      transferencias.add(Transferencia(
        valor: item['value'],
        conta: item['accountNumber'],
        contato: ItemContato(
          id: 0,
          nome: contatoJson['name'],
          conta: contatoJson['accountNumber'],
          onClick: null,
        ),
      ));
    }

    return transferencias;
  }

  HttpClientWithInterceptor _geClient() {
    return HttpClientWithInterceptor.build(interceptors: [
      LoggingInterceptor(),
    ]);
  }

  Future<Transferencia> save(Transferencia transferencia) async {
    final Client client = this._geClient();
    final Map<String, dynamic> transferenciaMap = {
      'value': transferencia.valor,
      'contact': {
        'name': transferencia.contato.nome,
        'accountNumber': transferencia.contato.conta
      }
    };

    final String transferenciaJson = jsonEncode(transferenciaMap);

    final Response response = await client.post(
      this._baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transferenciaJson,
    );

    Map<String, dynamic> json = jsonDecode(response.body);

    final Map<String, dynamic> contatoJson = json['contact'];

    return Transferencia(
      valor: json['value'],
      conta: contatoJson['accountNumber'],
      contato: ItemContato(
        id: 0,
        nome: contatoJson['name'],
        conta: contatoJson['accountNumber'],
        onClick: null,
      ),
    );
  }
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}
