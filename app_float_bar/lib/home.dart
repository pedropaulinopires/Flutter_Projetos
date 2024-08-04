import 'package:app_float_bar/components/bottom_navigation_bar_animated.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
      bottomNavigationBar: const BottomNavigationBarAnimated(),
    );
  }
}
