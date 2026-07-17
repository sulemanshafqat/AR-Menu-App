import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff2563EB)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected
                ? const Color(0xff2563EB)
                : Colors.grey.shade300,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: const Color(0xff2563EB).withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: selected ? Colors.white : Colors.black87,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}