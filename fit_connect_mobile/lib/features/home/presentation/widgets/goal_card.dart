import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GoalCard extends StatelessWidget {
  final double currentWeight;
  final double targetWeight;
  final double initialWeight;
  final DateTime? targetDate;
  final bool isLoading;

  const GoalCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
    required this.initialWeight,
    this.targetDate,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    
    final lostWeight = initialWeight - currentWeight;
    final remainingWeight = currentWeight - targetWeight;
    
    // Progress calculation
    // Total needed to lose: Initial - Target
    // Already lost: Initial - Current
    final totalToLose = initialWeight - targetWeight;
    final progressRaw = (lostWeight / totalToLose);
    final progress = progressRaw.clamp(0.0, 1.0);
    final percentage = (progress * 100).toInt();

    final daysLeft = targetDate?.difference(DateTime.now()).inDays;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary600, AppColors.primary700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary500.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(LucideIcons.scale, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Goal Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 3 Column Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        'Current',
                        '$currentWeight',
                        'kg',
                        isHighlighted: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatBox(
                        'Goal',
                        '$targetWeight',
                        'kg',
                        isHighlighted: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatBox(
                        'Left',
                        '-${remainingWeight.toStringAsFixed(1)}',
                        'kg',
                        isHighlighted: true,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Achievement Rate',
                      style: TextStyle(
                        color: AppColors.primary100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: AppColors.primary100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Deadline Info
                if (targetDate != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.calendar, color: AppColors.primary50, size: 14),
                            const SizedBox(width: 8),
                            Text(
                              'Target: ${_formatDate(targetDate!)}',
                              style: const TextStyle(
                                color: AppColors.primary50,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (daysLeft != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '$daysLeft Days Left',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, String unit, {required bool isHighlighted}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted ? null : Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: isHighlighted ? AppColors.primary600 : AppColors.primary100,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: isHighlighted ? AppColors.primary700 : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: TextStyle(
                    color: isHighlighted ? AppColors.primary700.withOpacity(0.8) : Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple formatter (can replace with intl package later)
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
