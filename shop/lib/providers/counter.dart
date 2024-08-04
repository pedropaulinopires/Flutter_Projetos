import 'package:flutter/material.dart';

class CounterState {
  int _valor = 0;

  void increment() => _valor++;
  void decrement() => _valor--;
  int getValor() => _valor;
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({super.key, required super.child});

  static CounterProvider? of(BuildContext contex) {
    return contex.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
