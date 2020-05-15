import 'package:bytebank/models/ItemContato.dart';

class Transferencia {
  final double valor;
  final ItemContato contato;

  Transferencia({this.contato, this.valor});

  Transferencia.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        contato = ItemContato.fromJson(json['contact']);
        
  Map<String, dynamic> toJson() =>
    {
      'value': valor,
      'contact':  contato.toJson()
    };
}
