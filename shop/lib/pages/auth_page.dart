import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shop/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(215, 117, 255, 0.5),
              Color.fromRGBO(255, 188, 117, 0.9)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  transform: Matrix4.rotationZ(-8 * pi/ 180)..translate(-10.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 175, 105, 100),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: const Text(
                    'Minha loja',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Anton',
                      fontSize: 39,
                    ),
                  ),
                ),
                const AuthForm()
              ],
            ),
          )
        ],
      ),
    );
  }
}
