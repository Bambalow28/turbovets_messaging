import 'package:flutter/material.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/knowledgebase_editor/knowledge_base_editor_page.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/live_logs/live_logs_page.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/messages/messages_list_screen.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/ticket_viewer/ticket_viewer_page.dart';
import 'package:turbovets_messaging_app/flutter_app/UI/widgets/menu_card.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=68',
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    MenuCard(
                      icon: Icons.message,
                      title: 'Messages',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesListScreen(),
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.confirmation_number,
                      title: 'Ticket Viewer',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TicketViewerPage(),
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.menu_book,
                      title: 'Knowledgebase Editor',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const KnowledgeBaseEditorPage(),
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.terminal,
                      title: 'Live Logs Panel',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LiveLogsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
