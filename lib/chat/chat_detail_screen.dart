import 'package:flutter/material.dart';

import '../models/product.dart';
import 'chat_bot.dart';
import 'chat_data.dart';

class ChatDetailScreen extends StatefulWidget {
  final String sellerName;
  final Product? product; 

  const ChatDetailScreen({super.key, required this.sellerName, this.product});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  static const Color primaryRed = Color(0xFFA01626);

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _quickReplies = [
    'Hai, barang ini ready?',
    'Bisa dikirim hari ini?',
    'Terima kasih',
  ];

  late final ChatThread _thread;

  Product? _attachedProduct;

  int _pendingReplies = 0;

  @override
  void initState() {
    super.initState();
    _thread = getOrCreateThread(widget.sellerName);
    _attachedProduct = widget.product;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  String _formatPrice(int price) {
    final text = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }
    return 'Rp$buffer';
  }
  Future<void> _botReply(String reply) async {
    setState(() {
      _pendingReplies++;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    await Future.delayed(const Duration(milliseconds: 1300));

    _thread.messages.add(
      ChatMessage(text: reply, isMe: false, isBot: true, time: nowTime()),
    );
    chatUpdate.value++;

    if (!mounted) {
      return;
    }

    setState(() {
      _pendingReplies--;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  // quickText diisi kalau yang diklik chip balasan cepat
  void sendMessage([String? quickText]) {
    final text = (quickText ?? _messageController.text).trim();
    if (text.isEmpty && _attachedProduct == null) {
      return;
    }

    final sentProduct = _attachedProduct;

    setState(() {
      if (sentProduct != null) {
        _thread.messages.add(
          ChatMessage(
            text: '',
            isMe: true,
            product: sentProduct,
            time: nowTime(),
          ),
        );
        _attachedProduct = null;
      }

      if (text.isNotEmpty) {
        _thread.messages.add(
          ChatMessage(text: text, isMe: true, time: nowTime()),
        );
      }
    });
    chatUpdate.value++; // kabarin list chat

    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // toko bales
    if (text.isNotEmpty) {
      _botReply(getBotReply(text, product: widget.product));
    } else if (sentProduct != null) {
      _botReply(getProductOnlyReply(sentProduct));
    }
  }

  Widget _buildProductImage(Product product, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        product.imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: Colors.grey[200],
          child: const Icon(Icons.image_not_supported, size: 20),
        ),
      ),
    );
  }

  // Banner di paling atas chat
  Widget _buildBanner() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            'Hati-hati penipuan! Mohon tidak bertransaksi di luar UntarianMart '
            'dan hindari menghubungi penjual selain melalui fitur Chat.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F5FA),
            border: Border.all(color: const Color(0xFFB5E1EE)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, size: 18, color: Color(0xFF2B8BAA)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Ada Gratis Ongkir untuk 1 transaksi di toko ini!',
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildProductBubble(ChatMessage message) {
    final product = message.product!;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 240,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _buildProductImage(product, 44),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatPrice(product.discountedPrice),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pesan teks biasa
  Widget _buildTextBubble(ChatMessage message) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? primaryRed : Colors.white,
          border: isMe ? null : Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
            if (message.isBot || message.time.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.isBot)
                    Text(
                      'Dikirim oleh chatbot',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  if (message.isBot && message.time.isNotEmpty)
                    const SizedBox(width: 24),
                  if (message.time.isNotEmpty)
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: isMe ? Colors.white70 : Colors.grey[500],
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Bubble "sedang mengetik..." dari toko
  Widget _buildTypingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Sedang mengetik...',
          style: TextStyle(
            fontSize: 13,
            fontStyle: FontStyle.italic,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachedProduct() {
    final product = _attachedProduct!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              _buildProductImage(product, 40),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatPrice(product.discountedPrice),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _attachedProduct = null;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Chip balasan cepat
  Widget _buildQuickReplies() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _quickReplies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final reply = _quickReplies[index];

          return InkWell(
            onTap: () => sendMessage(reply),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(reply, style: const TextStyle(fontSize: 13)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Kirim pesan...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => sendMessage(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: primaryRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showTyping = _pendingReplies > 0;
    final messageCount = _thread.messages.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.storefront, size: 18, color: primaryRed),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.sellerName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messageCount + 1 + (showTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildBanner();
                }

                if (index == messageCount + 1) {
                  return _buildTypingBubble();
                }

                final message = _thread.messages[index - 1];
                if (message.product != null) {
                  return _buildProductBubble(message);
                }
                return _buildTextBubble(message);
              },
            ),
          ),
          if (_attachedProduct != null) _buildAttachedProduct(),
          if (widget.product != null) _buildQuickReplies(),
          _buildInput(),
        ],
      ),
    );
  }
}