import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MealSummaryCard extends StatelessWidget {
  final String title;
  final String meals;
  final String photos;
  final String calories;

  const MealSummaryCard({
    super.key,
    required this.title,
    required this.meals,
    required this.photos,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary50, AppColors.indigo50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📊 ', style: TextStyle(fontSize: 14)),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.slate800,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildRow(LucideIcons.utensils, 'Meals', meals),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: AppColors.primary200.withOpacity(0.5)),
          ),
          _buildRow(LucideIcons.image, 'Photos', photos),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: AppColors.primary200.withOpacity(0.5)),
          ),
          _buildRow(LucideIcons.flame, 'Calories', calories),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.slate500),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.slate500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.slate800,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
