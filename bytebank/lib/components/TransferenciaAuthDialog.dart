import 'package:flutter/material.dart';

class TransferenciaAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const TransferenciaAuthDialog({Key key, @required this.onConfirm})
      : super(key: key);

  @override
  _TransferenciaAuthDialogState createState() =>
      _TransferenciaAuthDialogState();
}

class _TransferenciaAuthDialogState extends State<TransferenciaAuthDialog> {
  final TextEditingController _passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Autenticação"),
      content: TextField(
        controller: this._passwdController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(this._passwdController.text);

            Navigator.pop(context);
          },
          child: Text("Confirmar"),
        ),
      ],
    );
  }
}
