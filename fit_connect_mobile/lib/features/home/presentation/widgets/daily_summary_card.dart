import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Daily Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate800,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(LucideIcons.chevronRight, color: AppColors.slate400, size: 20),
                onPressed: () {
                    // Navigate to detail
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Meal Section
          _buildMealSection(),
          
          const SizedBox(height: 16),
          
          // Workout Section
          _buildWorkoutSection(),
          
          const Divider(height: 32, color: AppColors.slate50),
          
          // Weight Section
          _buildWeightSection(),
        ],
      ),
    );
  }

  Widget _buildMealSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.orange100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.utensils, color: AppColors.orange500, size: 16),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Meals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate800,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: '/3',
                    style: TextStyle(
                      color: AppColors.slate400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.67,
                  backgroundColor: AppColors.slate100,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.orange500),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '67% Logged',
                style: TextStyle(
                  color: AppColors.slate400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary100,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.dumbbell, color: AppColors.primary500, size: 16),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate700,
                    fontSize: 14,
                    height: 1.2,
                  ),
                ),
                Text(
                  'This week',
                  style: TextStyle(
                    color: AppColors.slate400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '3 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.slate800,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: '/ 7 Days',
                style: TextStyle(
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

  Widget _buildWeightSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.emerald100,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.scale, color: AppColors.emerald500, size: 16),
            ),
            const SizedBox(width: 10),
            const Text(
              'Weight',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.slate700,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '65.2 kg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.slate800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '-0.6kg vs yest.',
                style: TextStyle(
                  color: AppColors.emerald500,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
