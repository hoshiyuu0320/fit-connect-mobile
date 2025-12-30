import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/meal_records/presentation/screens/meal_record_screen.dart';
import 'package:fit_connect_mobile/features/weight_records/presentation/screens/weight_record_screen.dart';
import 'package:fit_connect_mobile/features/exercise_records/presentation/screens/exercise_record_screen.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50, // Matches background of inner screens
      appBar: AppBar(
        title: const Text(
          'Records',
          style: TextStyle(color: AppColors.slate800, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary600,
          unselectedLabelColor: AppColors.slate400,
          indicatorColor: AppColors.primary600,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Meals'),
            Tab(text: 'Weight'),
            Tab(text: 'Exercise'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MealRecordScreen(),
          WeightRecordScreen(),
          ExerciseRecordScreen(),
        ],
      ),
    );
  }
}
