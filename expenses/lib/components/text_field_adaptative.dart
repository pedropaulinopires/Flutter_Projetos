import 'package:expenses/plataforma_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAdaptative extends StatelessWidget {
  const TextFieldAdaptative(
      this.controller, this.onSubmit, this.keyboardType, this.label,
      {super.key});

  final TextEditingController controller;
  final Function() onSubmit;
  final TextInputType? keyboardType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return PlataformaEnum.isIOS
        ? Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: CupertinoTextField(
              controller: controller,
              cursorColor: Colors.black,
              onSubmitted: (_) => onSubmit() ,
              keyboardType: keyboardType,
              placeholder: label,
              style: TextStyle(fontSize: MediaQuery.textScalerOf(context).scale(18)),
              padding: const EdgeInsets.all(13),
            ),
        )
        : TextField(
            controller: controller,
            cursorColor: Colors.black,
            onSubmitted: (_) => onSubmit(),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              label: Text(label),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary)),
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          );
  }
}
