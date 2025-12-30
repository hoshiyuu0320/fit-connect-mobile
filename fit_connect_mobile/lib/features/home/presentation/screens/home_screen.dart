import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/home/presentation/widgets/goal_card.dart';
import 'package:fit_connect_mobile/features/home/presentation/widgets/daily_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data for MVP
    final now = DateTime.now();
    final targetDate = DateTime(2026, 3, 15);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTop(now),
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hello, Alex 👋',
                      style: TextStyle(
                        color: AppColors.slate800,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Let's keep the momentum going!",
                      style: TextStyle(
                        color: AppColors.slate600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Goal Card
              GoalCard(
                currentWeight: 65.2,
                targetWeight: 60.0,
                initialWeight: 67.5,
                targetDate: targetDate,
              ),

              const SizedBox(height: 24),

              // Daily Summary
              const DailySummaryCard(),
              
              const SizedBox(height: 100), // Bottom padding for FAB/Nav
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTop(DateTime date) {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[date.weekday % 7]}, ${months[date.month - 1]} ${date.day}';
  }
}
