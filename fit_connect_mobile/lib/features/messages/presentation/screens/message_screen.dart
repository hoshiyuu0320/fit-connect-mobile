import 'package:flutter/material.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/messages/presentation/widgets/message_bubble.dart';
import 'package:fit_connect_mobile/features/messages/presentation/widgets/chat_input.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Hello Alex! How are you doing today?',
      'isUser': false,
      'timestamp': '09:00',
    },
    {
      'message': '#Dining: Breakfast\nOatmeal and Bananas!',
      'isUser': true,
      'timestamp': '09:15',
      'tags': ['Dining: Breakfast'],
      'images': ['https://picsum.photos/seed/food1/300/300'],
    },
    {
      'message': '✨ Meal record automatically created',
      'isUser': false,
      'isSystem': true,
      'timestamp': '09:15',
    },
    {
      'message': 'Looks healthy! Good start!',
      'isUser': false,
      'timestamp': '09:20',
    },
  ];

  void _sendMessage(String text) {
    setState(() {
      _messages.add({
        'message': text,
        'isUser': true,
        'timestamp': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        // Basic Tag Parsing Logic for Demo
        'tags': text.contains('#meal') ? ['Dining: Lunch'] : 
                text.contains('#weight') ? ['Weight'] : 
                text.contains('#run') ? ['Activity: Cardio'] : null,
      });
      
      // Simulating system response
      if (text.contains('#')) {
         Future.delayed(const Duration(milliseconds: 500), () {
           if (mounted) {
             setState(() {
               _messages.add({
                 'message': '✨ Record automatically created',
                 'isUser': false,
                 'isSystem': true,
                 'timestamp': 'Now',
               });
             });
           }
         });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.slate200,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/seed/trainer/100/100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coach Sarah',
                    style: TextStyle(
                      color: AppColors.slate800,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.chevronDown, color: AppColors.slate400),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.slate100, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + 1, // +1 for date divider
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.slate100),
                        ),
                        child: const Text(
                          'Today, Dec 29',
                          style: TextStyle(
                            color: AppColors.slate400,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                
                final msg = _messages[index - 1];
                return MessageBubble(
                  message: msg['message'],
                  isUser: msg['isUser'],
                  timestamp: msg['timestamp'],
                  tags: msg['tags'],
                  images: msg['images'],
                  isSystem: msg['isSystem'] ?? false,
                );
              },
            ),
          ),
          ChatInput(onSend: _sendMessage),
        ],
      ),
    );
  }
}
