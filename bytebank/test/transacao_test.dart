import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar o valor quando criar uma transação', () {
    final transacao = Transferencia(id: null, valor: 200, contato: null);

    expect(transacao.valor, 200.0);
  });

  test(
      'Deve retornar um erro quando o criar uma transação com um valor abaixo de zero',
      () {
    expect(() => Transferencia(id: null, valor: 0, contato: null),
        throwsAssertionError);
  });
}
