import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';

class TagSuggestionList extends StatelessWidget {
  final String query;
  final Function(String tag, bool addSpace, String? example) onSelect;
  final FocusNode? textFieldFocusNode;

  const TagSuggestionList({
    super.key,
    required this.query,
    required this.onSelect,
    this.textFieldFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final suggestions = _getSuggestions(query);

    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    // 最初の候補の入力例を表示
    final exampleText = suggestions.first.example;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.slate100)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 入力例テキスト
          if (exampleText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                exampleText,
                style: const TextStyle(
                  color: AppColors.slate400,
                  fontSize: 12,
                ),
              ),
            ),
          // タグ候補ボタン
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final tag = suggestions[index];
                return _buildSuggestionBtn(tag);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionBtn(TagSuggestion tag) {
    return InkWell(
      onTap: () {
        onSelect(tag.tag, tag.addSpace, tag.example);
        // タグ選択後にTextFieldのフォーカスを維持
        textFieldFocusNode?.requestFocus();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.slate100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tag.icon),
            const SizedBox(width: 4),
            Text(
              tag.label,
              style: const TextStyle(
                color: AppColors.slate600,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TagSuggestion> _getSuggestions(String query) {
    if (query.isEmpty) return [];

    final normalizedQuery = query.replaceAll('#', '').toLowerCase().trim();

    final allTags = [
      // 食事
      const TagSuggestion(
          label: '#食事:朝食',
          icon: '🌅',
          tag: '#食事:朝食',
          keywords: ['食事', '朝食', 'meal', 'breakfast'],
          example: '例: #食事:朝食 トースト、目玉焼き、サラダ'),
      const TagSuggestion(
          label: '#食事:昼食',
          icon: '☀️',
          tag: '#食事:昼食',
          keywords: ['食事', '昼食', 'meal', 'lunch'],
          example: '例: #食事:昼食 サラダチキン、玄米おにぎり'),
      const TagSuggestion(
          label: '#食事:夕食',
          icon: '🌙',
          tag: '#食事:夕食',
          keywords: ['食事', '夕食', 'meal', 'dinner'],
          example: '例: #食事:夕食 鶏むね肉のグリル、味噌汁'),
      const TagSuggestion(
          label: '#食事:間食',
          icon: '🍪',
          tag: '#食事:間食',
          keywords: ['食事', '間食', 'meal', 'snack'],
          example: '例: #食事:間食 プロテインバー、ナッツ'),
      // 運動
      const TagSuggestion(
          label: '#運動:筋トレ',
          icon: '💪',
          tag: '#運動:筋トレ',
          keywords: ['運動', '筋トレ', 'exercise', 'workout', 'strength'],
          example: '例: #運動:筋トレ ベンチプレス 60分 350kcal'),
      const TagSuggestion(
          label: '#運動:有酸素',
          icon: '🏃',
          tag: '#運動:有酸素',
          keywords: ['運動', '有酸素', 'exercise', 'cardio', 'run'],
          example: '例: #運動:有酸素 ウォーキング 30分 3km 150kcal'),
      // 体重
      const TagSuggestion(
          label: '#体重',
          icon: '⚖️',
          tag: '#体重',
          keywords: ['体重', 'weight'],
          example: '例: #体重 65.5kg 順調に減ってきた！'),
    ];

    if (normalizedQuery.isEmpty) {
      // Show default categories if query is empty or just '#'
      return [
        const TagSuggestion(
            label: '#食事',
            icon: '🍽️',
            tag: '#食事',
            keywords: [],
            addSpace: false,
            example: '#食事:朝食 / 昼食 / 夕食 / 間食 から選択'),
        const TagSuggestion(
            label: '#運動',
            icon: '💪',
            tag: '#運動',
            keywords: [],
            addSpace: false,
            example: '#運動:筋トレ / 有酸素 から選択'),
        const TagSuggestion(
            label: '#体重',
            icon: '⚖️',
            tag: '#体重',
            keywords: [],
            example: '例: #体重 65.5kg'),
      ];
    }

    return allTags.where((tag) {
      if (tag.tag.toLowerCase().contains(normalizedQuery)) return true;
      for (final keyword in tag.keywords) {
        if (keyword.contains(normalizedQuery)) return true;
      }
      return false;
    }).toList();
  }
}

class TagSuggestion {
  final String label;
  final String icon;
  final String tag;
  final List<String> keywords;
  final bool addSpace;
  final String? example;

  const TagSuggestion({
    required this.label,
    required this.icon,
    required this.tag,
    required this.keywords,
    this.addSpace = true,
    this.example,
  });
}
