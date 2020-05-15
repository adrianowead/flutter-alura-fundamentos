
import 'package:bytebank/models/ItemContato.dart';

class Transferencia {
  final double valor;
  final int conta;
  final ItemContato contato;

  Transferencia({this.contato, this.valor, this.conta});

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $conta}';
  }
}
