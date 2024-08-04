import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resultado.dart';

void main() {
  runApp(AppPerguntas());
}

class AppPerguntas extends StatefulWidget {
  @override
  _AppPerguntasSate createState() => _AppPerguntasSate();
}

class _AppPerguntasSate extends State<AppPerguntas> {
  int _perguntaSelecionada = 0;
  List<Map<String, Object>> _perguntas = [
    {
      'texto': 'Qual é a sua cor favorita?',
      'resposta': [
        {'texto': 'Azul', 'nota': 10},
        {'texto': 'Preto', 'nota': 2},
        {'texto': 'Vermelho', 'nota': 3},
        {'texto': 'Verde', 'nota': 5},
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'resposta': [
        {'texto': 'Coelho', 'nota': 3},
        {'texto': 'Elefante', 'nota': 2},
        {'texto': 'Macaco', 'nota': 4},
        {'texto': 'Peixe', 'nota': 1},
      ]
    },
    {
      'texto': 'Qual é o seu framework favorito?',
      'resposta': [
        {'texto': 'React native', 'nota': 2},
        {'texto': 'Ionic', 'nota': 3},
        {'texto': 'Flutter', 'nota': 8},
        {'texto': 'Spring Boot', 'nota': 5},
      ]
    },
    {
      'texto': 'Qual é o seu instutor favorito?',
      'resposta': [
        {'texto': 'João', 'nota': 1},
        {'texto': 'Leo', 'nota': 8},
        {'texto': 'Rafa', 'nota': 2},
        {'texto': 'Pedro', 'nota': 4},
      ]
    },
    {
      'texto': 'Qual é o seu video game favorito?',
      'resposta': [
        {'texto': 'Xbox', 'nota': 1},
        {'texto': 'Playstation', 'nota': 3},
        {'texto': 'Nitendo Switch', 'nota': 2},
        {'texto': 'Atari', 'nota': 8},
      ]
    }
  ];
  int _pontuacao = 0;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada)
      setState(() {
        _perguntaSelecionada++;
        _pontuacao += pontuacao;
      });
  }

  void _resetarPerguntaSelecionada() {
    if (_perguntaSelecionada > 0) {
      setState(() {
        _perguntaSelecionada = 0;
        _pontuacao = 0;
      });
    }
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perguntas',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Colors.blue,
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntaSelecionada: _perguntaSelecionada,
                perguntasRespostas: _perguntas,
                responder: _responder,
              )
            : Resultado(_pontuacao, _resetarPerguntaSelecionada),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.restart_alt,
            color: Colors.white,
          ),
          onPressed:
              _perguntaSelecionada > 0 ? _resetarPerguntaSelecionada : null,
          backgroundColor: _perguntaSelecionada > 0
              ? Colors.blue
              : Color.fromARGB(255, 130, 130, 130),
          tooltip: 'Reiniciar questionário',
        ),
      ),
    );
  }
}
