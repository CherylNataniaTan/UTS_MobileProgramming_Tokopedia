import 'package:flutter/foundation.dart';

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}

class ChatThread {
  final String sellerName;
  final List<ChatMessage> messages;

  ChatThread({required this.sellerName, List<ChatMessage>? messages})
    : messages = messages ?? [];

  String get lastMessage =>
      messages.isEmpty ? 'Belum ada pesan' : messages.last.text;
}

final ValueNotifier<int> chatUpdate = ValueNotifier<int>(0);

final List<ChatThread> chatThreads = [
  ChatThread(
    sellerName: 'Clothing Store Official',
    messages: [
      ChatMessage(text: 'Halo kak, produknya masih ada?', isMe: false),
      ChatMessage(text: 'Ada kak, ready stock', isMe: true),
    ],
  ),
  ChatThread(
    sellerName: 'Footwear Hub',
    messages: [
      ChatMessage(text: 'Halo kak, ini sepatunya ready?', isMe: true),
      ChatMessage(text: 'Ongkirnya berapa ya kak?', isMe: true),
    ],
  ),
  ChatThread(
    sellerName: 'Essence Official Shop',
    messages: [
      ChatMessage(text: 'Pesanan sudah kami kirim ya kak', isMe: false),
      ChatMessage(text: 'Terima kasih sudah belanja!', isMe: false),
    ],
  ),
];

// Cari chat dengan toko ini, kalau belum ada bikin baru
ChatThread getOrCreateThread(String sellerName) {
  for (final thread in chatThreads) {
    if (thread.sellerName.toLowerCase() == sellerName.toLowerCase()) {
      return thread;
    }
  }

  final newThread = ChatThread(sellerName: sellerName);
  chatThreads.insert(0, newThread);
  chatUpdate.value++;
  return newThread;
}
