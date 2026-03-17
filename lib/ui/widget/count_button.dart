import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.buttonColor = const Color(0xFF4A6741),
    this.minQuantity = 0,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;
  final Color buttonColor;
  final int minQuantity;

  @override
  Widget build(BuildContext context) {
    final isDecrementEnabled = quantity > minQuantity;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(
          icon: Icons.remove,
          onPressed: isDecrementEnabled ? onDecrement : null,
          color: buttonColor,
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _QuantityButton(
          icon: Icons.add,
          onPressed: onIncrement,
          color: buttonColor,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return SizedBox(
      width: 28,
      height: 28,
      child: Material(
        color: isEnabled ? color : color.withValues(alpha: 0.4),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}