import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    this.canTap = true,
    this.onTap,
    required this.label,
    required this.backgroundColor,
  }) : super(key: key);
  final bool canTap;
  final Function()? onTap;
  final Widget label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: GestureDetector(
          onTap: canTap ? onTap : null,
          child: label,
        ),
      ),
    );
  }
}
