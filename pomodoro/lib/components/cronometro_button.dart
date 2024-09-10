import 'package:flutter/material.dart';

class CronometroButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? click;

  const CronometroButton({
    super.key,
    required this.text,
    required this.icon,
    this.click,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        onPressed: click,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}
