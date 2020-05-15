import 'dart:convert';

import 'package:bytebank/http/WebClient.dart';
import 'package:bytebank/models/ItemContato.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:http/http.dart';

class TransacaoWebClient extends WebClient{
  
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
    final Map<String, dynamic> transferenciaMap = _toMap(transferencia);

    final String transferenciaJson = jsonEncode(transferenciaMap);

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

  Map<String, dynamic> _toMap(Transferencia transferencia) {
    final Map<String, dynamic> transferenciaMap = {
      'value': transferencia.valor,
      'contact': {
        'name': transferencia.contato.nome,
        'accountNumber': transferencia.contato.conta
      }
    };
    return transferenciaMap;
  }

  Transferencia _toTransaction(Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    
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

  List<Transferencia> _toTransactions(List transacaoJson) {
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

}