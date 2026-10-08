import 'package:flutter/foundation.dart';

import '../models/product.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final Product? product; // kalau diisi, pesan ini berupa kartu produk
  final bool isBot;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    this.product,
    this.isBot = false,
    this.time = '',
  });
}

class ChatThread {
  final String sellerName;
  final List<ChatMessage> messages;

  ChatThread({required this.sellerName, List<ChatMessage>? messages})
      : messages = messages ?? [];

  String get lastMessage {
    if (messages.isEmpty) {
      return 'Belum ada pesan';
    }
    final last = messages.last;
    if (last.product != null) {
      return '[Produk] ${last.product!.name}';
    }
    return last.text;
  }
}

final ValueNotifier<int> chatUpdate = ValueNotifier<int>(0);

// Jam sekarang, format 08.42
String nowTime() {
  final now = DateTime.now();
  final h = now.hour.toString().padLeft(2, '0');
  final m = now.minute.toString().padLeft(2, '0');
  return '$h.$m';
}

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
// (chat baru otomatis dapat sapaan dari chatbot toko)
ChatThread getOrCreateThread(String sellerName) {
  for (final thread in chatThreads) {
    if (thread.sellerName.toLowerCase() == sellerName.toLowerCase()) {
      return thread;
    }
  }

  final newThread = ChatThread(
    sellerName: sellerName,
    messages: [
      ChatMessage(
        text: 'Terima kasih telah menghubungi kami. Apa yang bisa saya bantu hari ini?',
        isMe: false,
        isBot: true,
        time: nowTime(),
      ),
    ],
  );
  chatThreads.insert(0, newThread);
  chatUpdate.value++;
  return newThread;
}