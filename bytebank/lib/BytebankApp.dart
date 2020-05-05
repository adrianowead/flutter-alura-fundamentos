import 'package:flutter/material.dart';
import 'FormularioTransferencias.dart';

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencias(),
      ),
    );
  }
}
