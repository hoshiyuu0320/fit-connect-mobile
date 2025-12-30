import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ExerciseRecordScreen extends StatelessWidget {
  const ExerciseRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.indigo50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.indigo100),
          ),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text(
                 "📊 This Week's Summary",
                 style: TextStyle(
                    color: AppColors.slate800,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, 
                 ),
               ),
               const SizedBox(height: 16),
               Row(
                 children: [
                   Expanded(child: _buildSummaryStat('Total', '5', '📊')),
                   const SizedBox(width: 8),
                   Expanded(child: _buildSummaryStat('Strength', '3', '💪')),
                   const SizedBox(width: 8),
                   Expanded(child: _buildSummaryStat('Cardio', '2', '🏃')),
                 ],
               ),
             ],
          ),
        ),

        const SizedBox(height: 24),
        
        // List
        _buildExerciseCard(
           type: 'strength',
           title: 'Full Body Workout',
           time: '45 mins',
           date: 'Dec 29',
        ),
        _buildExerciseCard(
           type: 'cardio',
           title: 'Jogging in Park',
           time: '30 mins',
           date: 'Dec 28',
        ),
      ],
    );
  }

  Widget _buildSummaryStat(String label, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.slate500,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.slate800,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard({
    required String type,
    required String title,
    required String time,
    required String date,
  }) {
    final isStrength = type == 'strength';
    final color = isStrength ? AppColors.purple500 : AppColors.orange500;
    final bg = isStrength ? AppColors.purple50 : AppColors.orange50;
    final icon = isStrength ? '💪' : '🏃';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: [
           Container(
             width: 48,
             height: 48,
             decoration: BoxDecoration(
               color: bg,
               borderRadius: BorderRadius.circular(12),
             ),
             child: Center(
               child: Text(icon, style: const TextStyle(fontSize: 20)),
             ),
           ),
           const SizedBox(width: 16),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                       decoration: BoxDecoration(
                         color: bg,
                         borderRadius: BorderRadius.circular(4),
                       ),
                       child: Text(
                         type.toUpperCase(),
                         style: TextStyle(
                           color: color,
                           fontSize: 8,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                     const Spacer(),
                     Icon(LucideIcons.calendar, size: 12, color: AppColors.slate400),
                     const SizedBox(width: 4),
                     Text(
                       date,
                       style: const TextStyle(color: AppColors.slate400, fontSize: 10),
                     ),
                   ],
                 ),
                 const SizedBox(height: 4),
                 Text(
                   title,
                   style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     color: AppColors.slate800,
                     fontSize: 14,
                   ),
                 ),
                 const SizedBox(height: 2),
                 Text(
                   time,
                   style: const TextStyle(color: AppColors.slate500, fontSize: 12),
                 ),
               ],
             ),
           ),
        ],
      ),
    );
  }
}
