import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;

  const ChatInput({super.key, required this.onSend});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showSuggestions = _controller.text.contains('#');
      });
    });
  }

  void _addTag(String tag) {
    final text = _controller.text;
    _controller.text = '$text $tag ';
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    setState(() => _showSuggestions = false);
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSend(_controller.text);
      _controller.clear();
      setState(() => _showSuggestions = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_showSuggestions)
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildSuggestionBtn('Dining', '🍽️', '#meal'),
                const SizedBox(width: 8),
                _buildSuggestionBtn('Weight', '⚖️', '#weight'),
                const SizedBox(width: 8),
                _buildSuggestionBtn('Activity', '🏃', '#run'),
              ],
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
                          icon: const Icon(LucideIcons.camera, color: AppColors.slate400, size: 20),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            maxLines: 4,
                            minLines: 1,
                            decoration: const InputDecoration(
                              hintText: 'Message... (# for tags)',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                              hintStyle: TextStyle(color: AppColors.slate400, fontSize: 14),
                            ),
                            style: const TextStyle(color: AppColors.slate800, fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: _controller.text.trim().isEmpty ? null : _handleSend,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _controller.text.trim().isEmpty ? AppColors.slate200 : AppColors.primary600,
                      shape: BoxShape.circle,
                      boxShadow: _controller.text.trim().isEmpty 
                          ? null 
                          : [
                              BoxShadow(
                                color: AppColors.primary600.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: const Icon(LucideIcons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionBtn(String label, String icon, String tag) {
    return InkWell(
      onTap: () => _addTag(tag),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.slate100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Text(icon),
            const SizedBox(width: 4),
            Text(
              '#$label',
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
}
