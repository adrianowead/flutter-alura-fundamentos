import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final IconData icon;
  final Color colorIcon;

  const ResponseDialog({
    Key key,
    this.title,
    this.message,
    this.buttonText,
    this.icon,
    this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            this.icon,
            color: this.colorIcon,
            size: 64,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              this.message,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(this.buttonText),
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;

  const SuccessDialog(
      {Key key, this.title = "Sucesso!", @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: this.title,
      message: this.message,
      icon: Icons.cloud_done,
      colorIcon: Colors.green[600],
      buttonText: "Ok",
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  const ErrorDialog({Key key, this.title = "Falha!", @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: this.title,
      message: this.message,
      icon: Icons.warning,
      colorIcon: Colors.red[600],
      buttonText: "Ok",
    );
  }
}
