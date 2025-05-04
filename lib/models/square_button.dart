import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const SquareButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: isSelected ? Colors.grey : Colors.blue,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
