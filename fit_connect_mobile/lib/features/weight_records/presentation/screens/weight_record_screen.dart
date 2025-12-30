import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WeightRecordScreen extends StatelessWidget {
  const WeightRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Stats
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.slate100),
          ),
          child: Column(
            children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _buildTopStat('Current', '65.2', 'kg'),
                 Container(width: 1, height: 40, color: AppColors.slate100),
                 _buildTopStat('Goal', '60.0', 'kg', isAccent: true),
                 Container(width: 1, height: 40, color: AppColors.slate100),
                 _buildTopStat('Left', '-5.2', 'kg'),
               ],
             ),
             const SizedBox(height: 20),
             Row(
               children: [
                 Expanded(child: _buildComparisonBox('vs Last', '0.6kg')),
                 const SizedBox(width: 12),
                 Expanded(child: _buildComparisonBox('vs Start', '2.3kg')),
               ],
             ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Chart Placeholder (Fl_chart would go here)
        Container(
          height: 240,
          decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(24),
             border: Border.all(color: AppColors.slate100),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.barChart, size: 48, color: AppColors.primary100),
                const SizedBox(height: 8),
                Text(
                  'Weight Chart Area',
                  style: TextStyle(
                    color: AppColors.primary200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopStat(String label, String value, String unit, {bool isAccent = false}) {
    return Column(
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.slate400,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  color: isAccent ? AppColors.primary600 : AppColors.slate800,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  color: AppColors.slate400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.emerald50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
               color: AppColors.emerald600.withOpacity(0.7),
               fontSize: 10,
               fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.arrowDown, color: AppColors.emerald600, size: 14),
              const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.emerald600,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
