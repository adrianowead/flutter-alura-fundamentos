import 'package:bytebank/models/ItemContato.dart';

class Transferencia {
  final String id;
  final double valor;
  final ItemContato contato;

  Transferencia({this.id, this.contato, this.valor});

  Transferencia.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        contato = ItemContato.fromJson(json['contact']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'value': valor, 'contact': contato.toJson()};
}
