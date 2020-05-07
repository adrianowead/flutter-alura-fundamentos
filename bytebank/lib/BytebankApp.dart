import 'package:bytebank/screens/transferencias/Lista.dart';
import 'package:flutter/material.dart';

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      home: ListaTransferencias(),
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blue[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[700],
            textTheme: ButtonTextTheme.primary,
          )),
    );
  }
}
