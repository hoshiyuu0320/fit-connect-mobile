import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';

class MealCard extends StatelessWidget {
  final Map<String, dynamic> log;

  const MealCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    Color typeColor = AppColors.slate100;
    Color textColor = AppColors.slate600;
    String icon = '🍽️';

    switch (log['type']) {
      case 'Breakfast':
        typeColor = AppColors.amber100;
        textColor = AppColors.amber800;
        icon = '🍳';
        break;
      case 'Lunch':
        typeColor = AppColors.primary100;
        textColor = AppColors.primary700;
        icon = '🥗';
        break;
      case 'Dinner':
        typeColor = AppColors.rose100;
        textColor = AppColors.rose800;
        icon = '🥩';
        break;
      case 'Snack':
        typeColor = AppColors.indigo100;
        textColor = AppColors.indigo800;
        icon = '🍎';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
            child: log['imageUrl'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      log['imageUrl'],
                      fit: BoxFit.cover,
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
                    log['type'],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  log['title'],
                  style: const TextStyle(
                    color: AppColors.slate800,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text('⏰ ', style: TextStyle(fontSize: 10)),
                    Text(
                      log['time'],
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('🔥 ', style: TextStyle(fontSize: 10)),
                    Text(
                      '${log['calories']} kcal',
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
