import 'package:flutter/material.dart';

class BadgeItem extends StatelessWidget {
  const BadgeItem(
      {super.key,
      required this.value,
      required this.child,
      required this.visible,
      this.color});

  final Widget child;
  final Color? color;
  final String value;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        visible
            ? Positioned(
                top: 0,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: color ?? Colors.red,
                  ),
                  height: 19,
                  width: 19,
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
