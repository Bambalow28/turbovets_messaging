import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/messages/widgets/chat_bubble_widget.dart';
import 'package:turbovets_messaging_app/flutter_app/models/chat_message.dart';

class AnimatedChatBubble extends StatefulWidget {
  final ChatMessage chatMessage;
  final Animation<double> animation;
  const AnimatedChatBubble({
    super.key,
    required this.chatMessage,
    required this.animation,
  });

  @override
  State<AnimatedChatBubble> createState() => _AnimatedChatBubbleState();
}

class _AnimatedChatBubbleState extends State<AnimatedChatBubble> {
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    curvedAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOutBack,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: widget.animation, curve: Curves.easeOut),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        alignment: widget.chatMessage.isMe
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ChatBubbleWidget(chatMessage: widget.chatMessage),
      ),
    );
  }
}
