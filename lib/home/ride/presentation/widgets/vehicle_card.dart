import 'package:flutter/material.dart';
import 'package:nexride/core/theme/app_colors.dart';

import '../../domain/entities/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: vehicle.gradientColors.map((c) => Color(c)).toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vehicle.name,
                  style: const TextStyle(fontSize: 13, color: AppColors.textGrey, fontWeight: FontWeight.w600),
                ),
                Text(
                  vehicle.brandIcon,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                vehicle.imagePath,
                height: 110,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.directions_car_filled,
                  size: 90,
                  color: AppColors.primary.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: AppColors.textDark),
                children: [
                  TextSpan(text: '${vehicle.tagline} '),
                  TextSpan(
                    text: '\$${vehicle.price.toStringAsFixed(1)}',
                    style: const TextStyle(fontWeight: FontWeight.normal, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Text(vehicle.subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
