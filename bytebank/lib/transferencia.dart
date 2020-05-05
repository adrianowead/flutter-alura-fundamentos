class Transferecia {
  final double valor;
  final int conta;

  Transferecia({this.valor, this.conta});

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $conta}';
  }
}
