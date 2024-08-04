import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonAdaptative extends StatelessWidget {
  const ButtonAdaptative(this.label, this.submit, {super.key});

  final String label;
  final Function() submit;

  @override
  Widget build(BuildContext context) {
    return PlataformaEnum.isIOS
        ? CupertinoButton(
            color: Colors.orange,
            padding: const  EdgeInsets.symmetric(horizontal: 25),
            onPressed: submit,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black),
            ),
          )
        : ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
            ),
            onPressed: submit,
            child: Text(label),
          );
  }
}
