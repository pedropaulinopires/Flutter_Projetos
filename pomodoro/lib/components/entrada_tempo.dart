import 'package:flutter/material.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class EntradaTempo extends StatelessWidget {
  final String title;
  final int valor;
  final void Function()? inc;
  final void Function()? dec;

  const EntradaTempo({
    super.key,
    required this.title,
    required this.valor,
    this.inc,
    this.dec,
  });

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: dec,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                foregroundColor: Colors.white,
                backgroundColor:
                    store.estaTrabalhando() ? Colors.red : Colors.green,
              ),
              child: const Icon(Icons.arrow_downward),
            ),
            Text(
              '$valor min',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: inc,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                foregroundColor: Colors.white,
                backgroundColor:
                    store.estaTrabalhando() ? Colors.red : Colors.green,
              ),
              child: const Icon(Icons.arrow_upward),
            ),
          ],
        ),
      ],
    );
  }
}
