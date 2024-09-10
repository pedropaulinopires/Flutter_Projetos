import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/cronometro_button.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        return Container(
          color: store.estaTrabalhando() ? Colors.red : Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                store.estaTrabalhando() ? 'Hora de Descansar' : 'Hora de Trabalhar',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Text(
                '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 120, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CronometroButton(
                        text: 'Iniciar',
                        icon: Icons.play_arrow,
                        click: store.iniciar,
                      ),
                    ),
                  if (!store.iniciado)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CronometroButton(
                        text: 'Parar',
                        icon: Icons.stop,
                        click: store.parar,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CronometroButton(
                      text: 'Reiniciar',
                      icon: Icons.refresh,
                      click: store.reiniciar,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
