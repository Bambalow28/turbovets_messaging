import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/messages/message_card.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';
import 'package:turbovets_messaging_app/flutter_app/controllers/messages_controller.dart';
import 'package:turbovets_messaging_app/flutter_app/models/messages.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MessagesController _messagesController = MessagesController();
  String _searchQuery = '';

  List<Messages> get filteredMessages {
    return _messagesController.searchMessages(_searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search TextField
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: AppColors.greyColor),
                  prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            // Messages ListView
            Expanded(
              child: ListView.builder(
                itemCount: filteredMessages.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  return MessageCard(message: message);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.create, color: Colors.white),
      ),
    );
  }
}
