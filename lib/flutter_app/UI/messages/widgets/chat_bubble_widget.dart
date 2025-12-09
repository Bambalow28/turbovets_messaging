import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';
import 'package:turbovets_messaging_app/flutter_app/models/chat_message.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessage chatMessage;
  const ChatBubbleWidget({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatMessage.isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: chatMessage.isMe ? AppColors.buttonColor : AppColors.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: chatMessage.isMe
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: chatMessage.isMe
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chatMessage.text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              chatMessage.time,
              style: TextStyle(color: AppColors.greyColor, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
