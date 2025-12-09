import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/helpers/helpers.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/messages/widgets/animated_chat_bubble.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';
import 'package:turbovets_messaging_app/flutter_app/models/chat_message.dart';
import 'package:turbovets_messaging_app/flutter_app/models/messages.dart';

class ConversationList extends StatefulWidget {
  final Messages message;

  const ConversationList({super.key, required this.message});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<ChatMessage> _chatMessages = [
    ChatMessage(text: "Hey! How are you doing?", isMe: false, time: "10:00 AM"),
    ChatMessage(
      text: "I'm good, thanks! How about you?",
      isMe: true,
      time: "10:02 AM",
    ),
    ChatMessage(
      text: "Doing great! Feel free to ask me anything - I'm here to help!",
      isMe: false,
      time: "10:05 AM",
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      String userMessage = _messageController.text.trim();
      _messageController.clear();

      _chatMessages.add(
        ChatMessage(text: userMessage, isMe: true, time: "Now"),
      );
      _listKey.currentState?.insertItem(
        _chatMessages.length - 1,
        duration: const Duration(milliseconds: 350),
      );
      _scrollToBottom();

      // Simulate AI typing delay and then respond
      Future.delayed(const Duration(milliseconds: 900), () {
        _chatMessages.add(
          ChatMessage(
            text: Helpers().getAIResponse(userMessage),
            isMe: false,
            time: "Now",
          ),
        );
        _listKey.currentState?.insertItem(
          _chatMessages.length - 1,
          duration: const Duration(milliseconds: 350),
        );
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.message.imageUrl),
            ),
            const SizedBox(width: 12),
            Text(
              widget.message.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              initialItemCount: _chatMessages.length,
              itemBuilder: (context, index, animation) {
                final chatMessage = _chatMessages[index];
                return AnimatedChatBubble(
                  chatMessage: chatMessage,
                  animation: animation,
                );
              },
            ),
          ),
          // Message input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: AppColors.greyColor),
                        filled: true,
                        fillColor: AppColors.backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
