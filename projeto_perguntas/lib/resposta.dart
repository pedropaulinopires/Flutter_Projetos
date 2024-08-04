import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() onSelecao;

  Resposta(this.texto, this.onSelecao);

  final ButtonStyle estiloButton = ElevatedButton.styleFrom(
    alignment: Alignment.center,
    backgroundColor: Colors.blue,
    padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onSelecao,
        child: Text(
          texto,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: estiloButton,
      ),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
    );
  }
}
