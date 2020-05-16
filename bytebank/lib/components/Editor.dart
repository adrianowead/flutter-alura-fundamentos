import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController ctrl;
  final String rotulo;
  final String dica;
  final IconData icon;
  final TextInputType tipo;

  const Editor({
    this.ctrl,
    this.rotulo,
    this.dica,
    this.icon,
    this.tipo = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: TextField(
          controller: this.ctrl,
          style: TextStyle(fontSize: 24.0),
          keyboardType: this.tipo,
          decoration: InputDecoration(
            labelText: this.rotulo,
            hintText: this.dica,
            icon: this.icon != null ? Icon(this.icon) : null,
          ),
        ));
  }
}
