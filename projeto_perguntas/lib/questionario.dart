import 'package:flutter/cupertino.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/resposta.dart';

class Questionario extends StatelessWidget {
  Questionario({
    required this.perguntaSelecionada,
    required this.perguntasRespostas,
    required this.responder,
  });

  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntasRespostas;
  final void Function(int pontuacao) responder;

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntasRespostas.length;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntasRespostas[perguntaSelecionada]['resposta']
            as List<Map<String, Object>>
        : [];

    final List<Widget> respostasWidget = respostas.map((text) {
      return Resposta(
        text['texto'] as String,
        () => responder(text['nota'] as int),
      );
    }).toList();

    return Column(
      children: [
        Questao(perguntasRespostas[perguntaSelecionada]['texto'].toString()),
        ...respostasWidget
      ],
    );
  }
}
