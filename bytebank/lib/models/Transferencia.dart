import 'package:bytebank/models/ItemContato.dart';

class Transferencia {
  final double valor;
  final int conta;
  final ItemContato contato;

  Transferencia({this.contato, this.valor, this.conta});

  Transferencia.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        conta = json['accountNumber'],
        contato = ItemContato.fromJson(json['contact']);
        
  Map<String, dynamic> toJson() =>
    {
      'value': valor,
      'accountNumber': conta,
      'contact':  contato.toJson()
    };

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $conta}';
  }
}
