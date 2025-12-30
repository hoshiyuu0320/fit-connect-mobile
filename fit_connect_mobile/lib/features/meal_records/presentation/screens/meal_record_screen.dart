import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/meal_records/presentation/widgets/meal_card.dart';
import 'package:fit_connect_mobile/features/meal_records/presentation/widgets/meal_summary_card.dart';

class MealRecordScreen extends StatefulWidget {
  const MealRecordScreen({super.key});

  @override
  State<MealRecordScreen> createState() => _MealRecordScreenState();
}

class _MealRecordScreenState extends State<MealRecordScreen> {
  String _activePeriod = 'Today';

  final List<Map<String, dynamic>> _mockLogs = [
    {
      'id': '1',
      'type': 'Breakfast',
      'title': 'Oatmeal & Fruits',
      'time': '07:30',
      'calories': 450,
      'imageUrl': 'https://picsum.photos/seed/food1/200/200',
    },
    {
      'id': '2',
      'type': 'Lunch',
      'title': 'Chicken Salad',
      'time': '12:30',
      'calories': 620,
      'imageUrl': 'https://picsum.photos/seed/food2/200/200',
    },
    {
      'id': '3',
      'type': 'Snack',
      'title': 'Protein Bar',
      'time': '15:00',
      'calories': 180,
      // No image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Tabs
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.slate100),
          ),
          child: Row(
            children: ['Today', 'Week', 'Month', 'All'].map((tab) {
              final isActive = _activePeriod == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _activePeriod = tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary600 : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: AppColors.primary600.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: isActive ? Colors.white : AppColors.slate400,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Summary
        const MealSummaryCard(
          title: "Today's Summary",
          meals: "2/3",
          photos: "4",
          calories: "800 kcal",
        ),
        
        // Date Header
        const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Dec 29 (Sun)',
            style: TextStyle(
              color: AppColors.slate800,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(height: 1, color: AppColors.slate100),
        const SizedBox(height: 16),
        
        // List
        ..._mockLogs.map((log) => MealCard(log: log)),
      ],
    );
  }
}
