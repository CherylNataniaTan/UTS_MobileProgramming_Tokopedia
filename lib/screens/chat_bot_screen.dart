import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  static const Color primaryRed = Color(0xFFA01626);
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // State manajemen lokal untuk menyimpan riwayat pesan
  final List<Map<String, String>> _messages = [
    {
      'sender': 'bot',
      'text': 'Halo! Saya UntarianBot. Ada yang bisa saya bantu terkait kendala pesanan atau akun Anda?',
    },
  ];

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;

    final userMessage = _chatController.text.trim();

    // masukin pesan user
    setState(() {
      _messages.add({'sender': 'user', 'text': userMessage});
    });

    _chatController.clear();
    _scrollToBottom();

    //ngasih delay
    Future.delayed(const Duration(seconds: 1), () {
      _generateBotResponse(userMessage);
    });
  }

  void _generateBotResponse(String message) {
    String reply =
        'Maaf, saya kurang mengerti. Coba gunakan kata kunci seperti "checkout", "status pengiriman", atau "batal".';
    final lowerMsg = message.toLowerCase();

    //logika sederhana
    if (lowerMsg.contains('checkout')) {
      reply = 'Untuk kendala checkout, pastikan koneksi stabil, alamat sudah diisi lengkap, dan metode pembayaran tidak error.';
    } else if (lowerMsg.contains('status') ||
        lowerMsg.contains('resi') ||
        lowerMsg.contains('kirim')) {
      reply = 'Anda bisa mengecek status barang Anda dengan menekan tombol "Cek Status Pengiriman" di menu utama Pusat Bantuan.';
    } else if (lowerMsg.contains('batal') || lowerMsg.contains('cancel')) {
      reply = 'Pesanan hanya dapat dibatalkan jika statusnya masih "Pesanan Dibuat". Jika sudah diproses, Anda harus menghubungi penjual.';
    }

    setState(() {
      _messages.add({'sender': 'bot', 'text': reply});
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Chat Prioritas',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: primaryRed,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Area Obrolan
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? primaryRed : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //buat chat
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
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
                      controller: _chatController,
                      decoration: InputDecoration(
                        hintText: 'Ketik kendala Anda...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryRed,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _sendMessage,
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
