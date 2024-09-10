import 'package:flutter/material.dart';
import 'package:pomodoro/components/cronometro.dart';
import 'package:pomodoro/components/entrada_tempo.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Cronometro(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder:(ctx) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    title: 'Trabalho',
                    valor: store.tempoTrabalho,
                    inc: store.iniciado && store.estaTrabalhando() ? null : store.incrementTempoTrabalho,
                    dec: (store.iniciado && store.estaTrabalhando()) || store.tempoTrabalho == 1 ? null : store.decrementTempoTrabalho,
                  ),
                  EntradaTempo(
                    title: 'Descanso',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.estaDescansando() ? null : store.incrementTempoDescanso,
                    dec: (store.iniciado && store.estaDescansando()) || store.tempoDescanso == 1 ? null : store.decrementTempoDescanso,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
