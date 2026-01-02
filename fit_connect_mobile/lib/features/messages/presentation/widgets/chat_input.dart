import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/messages/presentation/widgets/tag_suggestion_list.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;

  const ChatInput({super.key, required this.onSend});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;
  String _currentTagQuery = '';
  String? _selectedTagHint; // タグ選択後に表示するヒント（タグ以降の部分）

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;
    final selection = _controller.selection;

    // テキスト変更時は必ず再描画して送信ボタンの状態を更新する
    setState(() {});

    if (selection.baseOffset >= 0) {
      final upToCursor = text.substring(0, selection.baseOffset);
      final lastHash = upToCursor.lastIndexOf('#');

      if (lastHash != -1) {
        final afterHash = upToCursor.substring(lastHash);
        // ハッシュの後にスペースや改行がない場合のみタグ入力中とみなす
        if (!afterHash.contains(' ') && !afterHash.contains('\n')) {
          if (mounted) {
            setState(() {
              _showSuggestions = true;
              _currentTagQuery = afterHash;
              _selectedTagHint = null; // タグ入力中はヒント非表示
            });
          }
          return;
        }

        // タグ+スペースの後、内容がまだ入力されていない場合はヒントを表示
        if (_selectedTagHint != null) {
          final spaceIndex = afterHash.indexOf(' ');
          if (spaceIndex != -1) {
            final afterSpace = afterHash.substring(spaceIndex + 1).trim();
            // 内容が入力されたらヒントを非表示
            if (afterSpace.isNotEmpty) {
              setState(() {
                _selectedTagHint = null;
              });
            }
          }
        }
      }
    }

    if (_showSuggestions && mounted) {
      setState(() {
        _showSuggestions = false;
        _currentTagQuery = '';
      });
    }
  }

  void _addTag(String tag, bool addSpace, String? example) {
    if (!_showSuggestions) return;

    final text = _controller.text;
    final selection = _controller.selection;
    final suffixSpace = addSpace ? ' ' : '';

    // 入力例からタグ以降の部分を抽出してヒントとして保存
    if (example != null && addSpace) {
      // "例: #食事:昼食 サラダチキン、玄米おにぎり" → "サラダチキン、玄米おにぎり"
      final tagPattern = RegExp(r'^例:\s*#[^\s]+\s+');
      final hintMatch = tagPattern.firstMatch(example);
      if (hintMatch != null) {
        _selectedTagHint = example.substring(hintMatch.end);
      }
    }

    if (selection.baseOffset < 0) {
      _controller.text = '$text $tag$suffixSpace';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    } else {
      final upToCursor = text.substring(0, selection.baseOffset);
      final lastHash = upToCursor.lastIndexOf('#');

      if (lastHash != -1) {
        final prefix = upToCursor.substring(0, lastHash);
        final suffix = text.substring(selection.baseOffset);

        final newText = '$prefix$tag$suffixSpace$suffix';
        _controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: prefix.length + tag.length + suffixSpace.length),
        );
      }
    }

    // 候補リストの表示状態は _onTextChanged リスナーがテキスト変更を検知して適切に更新するため、
    // ここで強制的に非表示にする必要はない。
  }

  /// タグを除いた本文があるかチェック
  bool _hasContentBesidesTag(String text) {
    // タグパターン: #食事:朝食, #運動:筋トレ, #体重 など
    final tagPattern = RegExp(r'#(食事|運動|体重)(?::[^\s]+)?');
    final withoutTags = text.replaceAll(tagPattern, '').trim();
    return withoutTags.isNotEmpty;
  }

  /// 送信可能かどうかを判定
  bool _canSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return false;

    // タグが含まれている場合は、タグ以外の内容が必要
    final hasTag = RegExp(r'#(食事|運動|体重)').hasMatch(text);
    if (hasTag) {
      return _hasContentBesidesTag(text);
    }

    // タグがない場合はそのまま送信可能
    return true;
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // タグのみの場合はエラー表示
    if (!_canSend()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('タグだけでなく、内容も入力してください'),
          backgroundColor: AppColors.orange500,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    widget.onSend(_controller.text);
    _controller.clear();
    setState(() {
      _showSuggestions = false;
      _selectedTagHint = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_showSuggestions)
          TagSuggestionList(
            query: _currentTagQuery,
            onSelect: _addTag,
            textFieldFocusNode: _focusNode,
          ),
        // タグ選択後のヒント表示（常に同じ高さを維持）
        if (!_showSuggestions)
          Container(
            width: double.infinity,
            height: 36, // 固定高さでレイアウト変化を防ぐ
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: Text(
              _selectedTagHint != null ? '例: $_selectedTagHint' : '',
              style: const TextStyle(
                color: AppColors.slate400,
                fontSize: 12,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.slate100)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.slate100,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(LucideIcons.camera,
                              color: AppColors.slate400, size: 20),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            maxLines: 4,
                            minLines: 1,
                            decoration: const InputDecoration(
                              hintText: 'Message... (# for tags)',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              hintStyle: TextStyle(
                                  color: AppColors.slate400, fontSize: 14),
                            ),
                            style: const TextStyle(
                                color: AppColors.slate800, fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: _canSend() ? _handleSend : null,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _canSend()
                          ? AppColors.primary600
                          : AppColors.slate200,
                      shape: BoxShape.circle,
                      boxShadow: _canSend()
                          ? [
                              BoxShadow(
                                color: AppColors.primary600.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: const Icon(LucideIcons.send,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
