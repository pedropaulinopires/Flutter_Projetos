import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(CounterProvider.of(context)?.state.getValor().toString() ?? "0"),
          IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)?.state.increment();
                });
              },
              icon: const Icon(Icons.add))
        ],
      )),
    );
  }
}
