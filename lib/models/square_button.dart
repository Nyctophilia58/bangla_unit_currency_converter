import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final String imagePath;

  const SquareButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
    required this.imagePath,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 30,
              width: 30,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        )
      ),
    );
  }
}
