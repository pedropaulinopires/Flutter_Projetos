import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nativo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _b = 0;
  int _a = 0;
  int _sum = 0;

  Future<void> _sumNumbers() async {
    const channel = MethodChannel('pedro.com.br/nativo');

    try {
      final sum = await channel.invokeMethod('sumNumbers', {"a": _a, "b": _b});

      setState(() {
        _sum = sum;
      });
    } on PlatformException {
      setState(() {
        _sum = _a + _b;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nativo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soma...$_sum',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _a = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _b = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: _sumNumbers,
                child: const Text('Somar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
