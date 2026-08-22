import 'package:flutter/material.dart';
import 'package:nexride/core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.directions_car_filled, label: 'My Trip'),
    (icon: Icons.chat_bubble_outline, label: 'Feedback'),
    (icon: Icons.person_outline, label: 'Account'),
    (icon: Icons.grid_view_rounded, label: 'More'),
    (icon: Icons.auto_awesome, label: 'Nex-AI'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: isSelected ? Colors.white : Colors.white70,
                  size: 22,
                ),
                if (isSelected) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}