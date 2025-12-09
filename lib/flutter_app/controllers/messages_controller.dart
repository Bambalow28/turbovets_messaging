import 'package:turbovets_messaging_app/flutter_app/models/messages.dart';

class MessagesController {
  static final MessagesController _instance = MessagesController._internal();

  factory MessagesController() {
    return _instance;
  }

  MessagesController._internal();

  final List<Messages> _messages = [
    Messages(
      name: 'Sarah Johnson',
      message:
          'Hey! Are you coming to the party tonight? It would be great to see you there!',
      time: '2:30 PM',
      unreadCount: 3,
      imageUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Messages(
      name: 'Mike Chen',
      message:
          'The project deadline has been moved to next Friday. Let me know if you need any help.',
      time: '1:45 PM',
      unreadCount: 0,
      imageUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    Messages(
      name: 'Emily Davis',
      message:
          'Thanks for the coffee today! We should do it again sometime soon.',
      time: '12:20 PM',
      unreadCount: 1,
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    Messages(
      name: 'James Wilson',
      message: 'Did you see the game last night? What an incredible finish!',
      time: '11:00 AM',
      unreadCount: 5,
      imageUrl: 'https://i.pravatar.cc/150?img=8',
    ),
    Messages(
      name: 'Lisa Anderson',
      message:
          'I just sent you the files. Please review them when you get a chance.',
      time: '10:15 AM',
      unreadCount: 0,
      imageUrl: 'https://i.pravatar.cc/150?img=9',
    ),
    Messages(
      name: 'David Brown',
      message: 'Happy birthday! Hope you have an amazing day filled with joy!',
      time: 'Yesterday',
      unreadCount: 0,
      imageUrl: 'https://i.pravatar.cc/150?img=11',
    ),
    Messages(
      name: 'Anna Martinez',
      message: 'Can we reschedule our meeting to Thursday? Something came up.',
      time: 'Yesterday',
      unreadCount: 2,
      imageUrl: 'https://i.pravatar.cc/150?img=16',
    ),
    Messages(
      name: 'Chris Taylor',
      message:
          'Check out this new restaurant I found. The food is absolutely delicious!',
      time: 'Monday',
      unreadCount: 0,
      imageUrl: 'https://i.pravatar.cc/150?img=12',
    ),
  ];

  List<Messages> get messages => _messages;

  List<Messages> searchMessages(String query) {
    if (query.isEmpty) {
      return _messages;
    }
    return _messages.where((message) {
      final nameLower = message.name.toLowerCase();
      final messageLower = message.message.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) ||
          messageLower.contains(queryLower);
    }).toList();
  }

  void addMessage(Messages message) {
    _messages.insert(0, message);
  }

  void removeMessage(Messages message) {
    _messages.remove(message);
  }

  Messages? getMessageByName(String name) {
    try {
      return _messages.firstWhere((m) => m.name == name);
    } catch (e) {
      return null;
    }
  }
}
