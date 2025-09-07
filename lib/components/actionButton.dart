import 'package:fampay/utils/parse_color.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final IconData icon;

  const ActionButton({
    required this.label,
    required this.onTap,
    this.color = Colors.white,
    this.textColor = Colors.black, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: parseColor('#F7F6F3'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      ),
      onPressed: onTap,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: textColor)),
      ],
    ),
    );
  }
}