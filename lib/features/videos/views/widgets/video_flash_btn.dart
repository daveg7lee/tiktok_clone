import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final IconData icon;
  final bool isSelect;
  final void Function()? onPressed;

  const FlashButton(
      {super.key, required this.icon, required this.isSelect, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelect ? Colors.amber : Colors.white,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
