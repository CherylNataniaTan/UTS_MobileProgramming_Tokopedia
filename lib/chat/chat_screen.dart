import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatThread {
  final String sellerName;
  final String lastMessage;

  const ChatThread({required this.sellerName, required this.lastMessage});   
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const Color primaryRed = Color(0xFFA01626);

  final List<ChatThread> _threads = const [
    ChatThread(sellerName: 'Clothing Store Official', lastMessage: 'Ada kak, ready stock'),
    ChatThread(sellerName: 'Footwear Hub', lastMessage: 'Ongkirnya berapa ya kak?'),
    ChatThread(sellerName: 'Essence Official Shop', lastMessage: 'Terima kasih sudah belanja!'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _threads.length,
        itemBuilder: (context, index) {
          final thread = _threads[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatDetailScreen(sellerName: thread.sellerName),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryRed.withOpacity(0.15),
                    child: Icon(Icons.storefront, color: primaryRed),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thread.sellerName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          thread.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}