import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/core/theme/app_theme.dart';
import 'package:fit_connect_mobile/features/exercise_records/models/exercise_record_model.dart';
import 'package:fit_connect_mobile/features/exercise_records/providers/exercise_records_provider.dart';
import 'package:fit_connect_mobile/shared/models/period_filter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class ExerciseRecordScreen extends ConsumerStatefulWidget {
  const ExerciseRecordScreen({super.key});

  @override
  ConsumerState<ExerciseRecordScreen> createState() =>
      _ExerciseRecordScreenState();
}

class _ExerciseRecordScreenState extends ConsumerState<ExerciseRecordScreen> {
  PeriodFilter _selectedPeriod = PeriodFilter.week;
  String? _selectedType; // null = all, 'strength_training', 'cardio'

  @override
  Widget build(BuildContext context) {
    final recordsAsync = ref.watch(
      exerciseRecordsProvider(
        period: _selectedPeriod,
        exerciseType: _selectedType,
      ),
    );
    final typeCountsAsync = ref.watch(
      exerciseTypeCountsProvider(period: _selectedPeriod),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Period Filter
        _buildPeriodFilter(),
        const SizedBox(height: 16),

        // Exercise Type Filter
        _buildTypeFilter(),
        const SizedBox(height: 24),

        // Summary Card
        _buildSummaryCard(recordsAsync, typeCountsAsync),
        const SizedBox(height: 24),

        // Exercise Records List
        _buildRecordsList(recordsAsync),
      ],
    );
  }

  Widget _buildPeriodFilter() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: PeriodFilter.values.map((period) {
          final isActive = period == _selectedPeriod;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.indigo600 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.indigo600.withAlpha(77),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    period.shortLabel,
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.slate400,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTypeFilter() {
    final types = [
      (null, 'All', LucideIcons.layoutGrid),
      ('strength_training', 'Strength', LucideIcons.dumbbell),
      ('cardio', 'Cardio', LucideIcons.heart),
    ];

    return Row(
      children: types.map((type) {
        final isActive = _selectedType == type.$1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: type.$1 == null ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () => setState(() => _selectedType = type.$1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.indigo50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive ? AppColors.indigo100 : AppColors.slate200,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      type.$3,
                      size: 16,
                      color:
                          isActive ? AppColors.indigo600 : AppColors.slate400,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      type.$2,
                      style: TextStyle(
                        color:
                            isActive ? AppColors.indigo600 : AppColors.slate500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard(
    AsyncValue<List<ExerciseRecord>> recordsAsync,
    AsyncValue<Map<String, int>> typeCountsAsync,
  ) {
    return Container(
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
      child: typeCountsAsync.when(
        data: (typeCounts) {
          final total = typeCounts.values.fold<int>(0, (sum, v) => sum + v);
          final strength = typeCounts['strength_training'] ?? 0;
          final cardio = typeCounts['cardio'] ?? 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedPeriod == PeriodFilter.week
                    ? "📊 This Week's Summary"
                    : "📊 ${_selectedPeriod.label} Summary",
                style: const TextStyle(
                  color: AppColors.slate800,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child:
                          _buildSummaryStat('Total', total.toString(), '📊')),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _buildSummaryStat(
                          'Strength', strength.toString(), '💪')),
                  const SizedBox(width: 8),
                  Expanded(
                      child:
                          _buildSummaryStat('Cardio', cardio.toString(), '🏃')),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(153),
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

  Widget _buildRecordsList(AsyncValue<List<ExerciseRecord>> recordsAsync) {
    return recordsAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.dumbbell,
                      size: 48, color: AppColors.slate300),
                  const SizedBox(height: 12),
                  const Text(
                    'No exercise records yet',
                    style: TextStyle(color: AppColors.slate400),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start logging your workouts!',
                    style: TextStyle(color: AppColors.slate300, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }

        // Group records by date
        final groupedRecords = _groupRecordsByDate(records);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedRecords.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    _formatDateHeader(entry.key),
                    style: const TextStyle(
                      color: AppColors.slate800,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.slate100),
                const SizedBox(height: 16),
                // Exercise Cards
                ...entry.value.map((record) => _buildExerciseCard(record)),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Map<DateTime, List<ExerciseRecord>> _groupRecordsByDate(
      List<ExerciseRecord> records) {
    final Map<DateTime, List<ExerciseRecord>> grouped = {};
    for (final record in records) {
      final date = DateTime(
        record.recordedAt.year,
        record.recordedAt.month,
        record.recordedAt.day,
      );
      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(record);
    }
    return grouped;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d (E)').format(date);
    }
  }

  Widget _buildExerciseCard(ExerciseRecord record) {
    final isStrength = record.exerciseType == 'strength_training';
    final color = isStrength ? AppColors.purple500 : AppColors.orange500;
    final bg = isStrength ? AppColors.purple50 : AppColors.orange50;
    final icon = isStrength ? '💪' : '🏃';
    final typeLabel = _getExerciseTypeLabel(record.exerciseType);

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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        typeLabel.toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(LucideIcons.clock,
                        size: 12, color: AppColors.slate400),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('HH:mm').format(record.recordedAt),
                      style: const TextStyle(
                          color: AppColors.slate400, fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  record.memo ?? typeLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate800,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (record.duration != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${record.duration} mins',
                    style: const TextStyle(
                        color: AppColors.slate500, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getExerciseTypeLabel(String type) {
    switch (type) {
      case 'strength_training':
        return 'Strength';
      case 'cardio':
        return 'Cardio';
      case 'walking':
        return 'Walking';
      case 'running':
        return 'Running';
      case 'cycling':
        return 'Cycling';
      case 'swimming':
        return 'Swimming';
      case 'yoga':
        return 'Yoga';
      case 'pilates':
        return 'Pilates';
      default:
        return 'Other';
    }
  }
}

// ============================================
// Previews
// ============================================

@Preview(name: 'ExerciseRecordScreen - Static Preview')
Widget previewExerciseRecordScreenStatic() {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Period Filter Preview
            _PreviewPeriodFilter(),
            const SizedBox(height: 16),

            // Type Filter Preview
            _PreviewTypeFilter(),
            const SizedBox(height: 24),

            // Summary Card Preview
            _PreviewSummaryCard(),
            const SizedBox(height: 24),

            // Records List Preview
            _PreviewRecordsList(),
          ],
        ),
      ),
    ),
  );
}

@Preview(name: 'ExerciseRecordScreen - Empty State')
Widget previewExerciseRecordScreenEmpty() {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Period Filter Preview
            _PreviewPeriodFilter(),
            const SizedBox(height: 16),

            // Type Filter Preview
            _PreviewTypeFilter(),
            const SizedBox(height: 24),

            // Empty Summary Card
            _PreviewSummaryCardEmpty(),
            const SizedBox(height: 24),

            // Empty State
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.dumbbell,
                        size: 48, color: AppColors.slate300),
                    const SizedBox(height: 12),
                    const Text(
                      'No exercise records yet',
                      style: TextStyle(color: AppColors.slate400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Preview helper widgets
class _PreviewPeriodFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children:
            ['Today', 'Week', 'Month', '3M', 'All'].asMap().entries.map((e) {
          final isActive = e.key == 1; // Week is active
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.indigo600 : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  e.value,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.slate400,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PreviewTypeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final types = [
      ('All', LucideIcons.layoutGrid, true),
      ('Strength', LucideIcons.dumbbell, false),
      ('Cardio', LucideIcons.heart, false),
    ];

    return Row(
      children: types.asMap().entries.map((entry) {
        final type = entry.value;
        final isActive = type.$3;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: entry.key == 0 ? 0 : 8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? AppColors.indigo50 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? AppColors.indigo100 : AppColors.slate200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    type.$2,
                    size: 16,
                    color: isActive ? AppColors.indigo600 : AppColors.slate400,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    type.$1,
                    style: TextStyle(
                      color:
                          isActive ? AppColors.indigo600 : AppColors.slate500,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PreviewSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Expanded(child: _buildStat('Total', '5', '📊')),
              const SizedBox(width: 8),
              Expanded(child: _buildStat('Strength', '3', '💪')),
              const SizedBox(width: 8),
              Expanded(child: _buildStat('Cardio', '2', '🏃')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(153),
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
}

class _PreviewSummaryCardEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Expanded(child: _PreviewSummaryCard()._buildStat('Total', '0', '📊')),
              const SizedBox(width: 8),
              Expanded(child: _PreviewSummaryCard()._buildStat('Strength', '0', '💪')),
              const SizedBox(width: 8),
              Expanded(child: _PreviewSummaryCard()._buildStat('Cardio', '0', '🏃')),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewRecordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today',
          style: TextStyle(
            color: AppColors.slate800,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(height: 24, color: AppColors.slate100),
        ..._mockExerciseRecords.map((record) => _buildExerciseCard(record)),
      ],
    );
  }

  Widget _buildExerciseCard(ExerciseRecord record) {
    final isStrength = record.exerciseType == 'strength_training';
    final color = isStrength ? AppColors.purple500 : AppColors.orange500;
    final bg = isStrength ? AppColors.purple50 : AppColors.orange50;
    final icon = isStrength ? '💪' : '🏃';
    final typeLabel = isStrength ? 'Strength' : 'Cardio';

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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        typeLabel.toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(LucideIcons.clock,
                        size: 12, color: AppColors.slate400),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('HH:mm').format(record.recordedAt),
                      style: const TextStyle(
                          color: AppColors.slate400, fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  record.memo ?? typeLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate800,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (record.duration != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${record.duration} mins',
                    style: const TextStyle(
                        color: AppColors.slate500, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Mock data for previews
final _mockExerciseRecords = [
  ExerciseRecord(
    id: '1',
    clientId: 'client-1',
    exerciseType: 'strength_training',
    memo: 'Full Body Workout - Squats, Deadlifts, Bench Press',
    images: null,
    duration: 45,
    distance: null,
    calories: 320,
    recordedAt: DateTime.now().subtract(const Duration(hours: 2)),
    source: 'manual',
    messageId: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  ExerciseRecord(
    id: '2',
    clientId: 'client-1',
    exerciseType: 'cardio',
    memo: 'Morning Jog in the Park',
    images: null,
    duration: 30,
    distance: 5.0,
    calories: 280,
    recordedAt: DateTime.now().subtract(const Duration(hours: 8)),
    source: 'message',
    messageId: 'msg-1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  ExerciseRecord(
    id: '3',
    clientId: 'client-1',
    exerciseType: 'strength_training',
    memo: 'Upper Body - Pull-ups, Rows, Curls',
    images: null,
    duration: 40,
    distance: null,
    calories: 250,
    recordedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    source: 'manual',
    messageId: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
