import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/messages/widgets/conversation_list.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';
import 'package:turbovets_messaging_app/flutter_app/models/messages.dart';

class MessageCard extends StatelessWidget {
  final Messages message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationList(message: message),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Circle Avatar Image
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(message.imageUrl),
            ),
            const SizedBox(width: 12),
            // Name, unread count, and message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        message.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (message.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${message.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Time
            Text(
              message.time,
              style: TextStyle(color: AppColors.greyColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
