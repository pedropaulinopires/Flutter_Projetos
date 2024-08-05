import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(0, 5))
                  ]),
              height: 250,
              width: 250,
              child: const Column(
                children: [Text('Teste')],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(0, 5))
                  ]),
              height: 250,
              width: 250,
              child: const Column(
                children: [Text('Teste')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
