import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String timestamp;
  final List<String>? tags;
  final List<String>? images;
  final bool isSystem;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.tags,
    this.images,
    this.isSystem = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isSystem) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.amber100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.amber700.withOpacity(0.2)),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.amber800,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, top: 2),
              decoration: const BoxDecoration(
                color: AppColors.slate200,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/seed/trainer/100/100'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary600 : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: isUser ? null : Border.all(color: AppColors.slate100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.isNotEmpty)
                        Text(
                          message,
                          style: TextStyle(
                            color: isUser ? Colors.white : AppColors.slate800,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      
                      // Tags
                      if (tags != null && tags!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: tags!.map((tag) => _buildTag(tag, isUser)).toList(),
                        ),
                      ],
                      
                      // Images
                      if (images != null && images!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: images!.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 4),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  images![index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: const TextStyle(
                    color: AppColors.slate400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag, bool isUser) {
    String icon = '';
    if (tag.contains('Dining')) icon = '🍽️';
    if (tag.contains('Weight')) icon = '⚖️';
    if (tag.contains('Activity')) icon = '🏃';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isUser ? Colors.white.withOpacity(0.2) : AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$icon $tag',
        style: TextStyle(
          color: isUser ? Colors.white : AppColors.primary600,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
