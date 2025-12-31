import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/meal_records/models/meal_record_model.dart';
import 'package:intl/intl.dart';

class MealCard extends StatelessWidget {
  final MealRecord record;

  const MealCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final (typeColor, textColor, icon, typeLabel) = _getMealTypeStyle(record.mealType);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image or Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: record.images != null && record.images!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      record.images!.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(icon, style: const TextStyle(fontSize: 32)),
                      ),
                    ),
                  )
                : Center(child: Text(icon, style: const TextStyle(fontSize: 32))),
          ),

          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    typeLabel,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  record.notes ?? typeLabel,
                  style: const TextStyle(
                    color: AppColors.slate800,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text('⏰ ', style: TextStyle(fontSize: 10)),
                    Text(
                      DateFormat('HH:mm').format(record.recordedAt),
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 12,
                      ),
                    ),
                    if (record.calories != null) ...[
                      const SizedBox(width: 12),
                      const Text('🔥 ', style: TextStyle(fontSize: 10)),
                      Text(
                        '${record.calories!.toInt()} kcal',
                        style: const TextStyle(
                          color: AppColors.slate500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color, String, String) _getMealTypeStyle(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return (AppColors.amber100, AppColors.amber800, '🍳', 'Breakfast');
      case 'lunch':
        return (AppColors.primary100, AppColors.primary700, '🥗', 'Lunch');
      case 'dinner':
        return (AppColors.rose100, AppColors.rose800, '🥩', 'Dinner');
      case 'snack':
        return (AppColors.indigo100, AppColors.indigo800, '🍎', 'Snack');
      default:
        return (AppColors.slate100, AppColors.slate600, '🍽️', mealType);
    }
  }
}
