import 'package:flutter/material.dart';

import '../services/local_account_service.dart';
import '../services/review_service.dart';

class ProductReviewSection extends StatefulWidget {
  final String productId;
  final double baseRating;
  final bool canReview; // true kalau pesanan produk ini sudah Selesai

  const ProductReviewSection({
    super.key,
    required this.productId,
    required this.baseRating,
    this.canReview = false,
  });

  @override
  State<ProductReviewSection> createState() => _ProductReviewSectionState();
}

class _ProductReviewSectionState extends State<ProductReviewSection> {
  static const Color green = Color(0xFFA01626);

  List<ProductReview> _userReviews = [];
  late final List<ProductReview> _generated;
  String _myUsername = 'guest';
  String _myName = 'Pengguna';

  int _filter = 0; // 0 = semua, 1-5 = bintang
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    _generated = ReviewService.generated(widget.productId, widget.baseRating);
    _load();
  }

  Future<void> _load() async {
    final mine = await ReviewService.getUserReviews(widget.productId);
    final current = await LocalAccountService.getCurrent();
    if (!mounted) return;
    setState(() {
      _userReviews = mine;
      _myUsername = (current?['username'] ?? 'guest').toString();
      _myName = (current?['name'] ?? 'Pengguna').toString();
    });
  }

  List<ProductReview> get _all => [..._userReviews, ..._generated];

  ProductReview? get _myReview {
    for (final r in _userReviews) {
      if (r.username == _myUsername) return r;
    }
    return null;
  }

  String _ratingLabel(int r) {
    switch (r) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Cukup';
      case 4:
        return 'Bagus';
      default:
        return 'Sangat Bagus';
    }
  }

  Future<void> _openForm() async {
    // hanya pembeli yang pesanannya sudah selesai yang boleh menulis ulasan
    if (!widget.canReview) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kamu bisa menulis ulasan setelah pesanan selesai'),
        ),
      );
      return;
    }

    final existing = _myReview;
    int rating = existing?.rating ?? 0;
    final commentC = TextEditingController(text: existing?.comment ?? '');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheet) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      existing == null ? 'Tulis Ulasan' : 'Ubah Ulasan',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Bagaimana kualitas produk ini?'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (int i = 1; i <= 5; i++)
                          GestureDetector(
                            onTap: () => setSheet(() => rating = i),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.star,
                                size: 38,
                                color: i <= rating
                                    ? Colors.amber
                                    : Colors.grey[300],
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (rating > 0)
                          Text(
                            _ratingLabel(rating),
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: commentC,
                      maxLines: 4,
                      maxLength: 300,
                      decoration: InputDecoration(
                        hintText: 'Ceritakan pengalamanmu dengan produk ini',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          if (rating == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pilih jumlah bintang dulu ya'),
                              ),
                            );
                            return;
                          }
                          await ReviewService.saveReview(
                            widget.productId,
                            ProductReview(
                              name: _myName,
                              username: _myUsername,
                              rating: rating,
                              comment: commentC.text.trim(),
                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            ),
                          );
                          if (sheetContext.mounted) Navigator.pop(sheetContext);
                        },
                        child: const Text(
                          'Kirim Ulasan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    commentC.dispose();
    await _load();
  }

  Future<void> _delete() async {
    await ReviewService.deleteReview(widget.productId, _myUsername);
    await _load();
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Ulasan dihapus')));
  }

  Widget _stars(int rating, {double size = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            Icons.star,
            size: size,
            color: i <= rating ? Colors.amber : Colors.grey[300],
          ),
      ],
    );
  }

  Widget _summary(List<ProductReview> all) {
    final total = all.length;
    final avg = total == 0
        ? 0.0
        : all.fold<int>(0, (s, r) => s + r.rating) / total;
    final counts = {for (int i = 1; i <= 5; i++) i: 0};
    for (final r in all) {
      counts[r.rating] = counts[r.rating]! + 1;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 32),
                const SizedBox(width: 4),
                Text(
                  avg.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' / 5.0',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$total ulasan',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              for (int s = 5; s >= 1; s--)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text('$s', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: total == 0 ? 0 : counts[s]! / total,
                            minHeight: 6,
                            backgroundColor: Colors.grey[200],
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(green),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 20,
                        child: Text(
                          '${counts[s]}',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewItem(ProductReview r) {
    final mine = r.username == _myUsername && r.createdAt != 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _stars(r.rating),
              const SizedBox(width: 6),
              Text(
                r.timeAgo,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Spacer(),
              if (mine) ...[
                InkWell(
                  onTap: _openForm,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.edit_outlined, size: 18, color: green),
                  ),
                ),
                InkWell(
                  onTap: _delete,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey[300],
                child: Text(
                  r.name.isNotEmpty ? r.name[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                r.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (mine) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F6E6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Ulasan kamu',
                    style: TextStyle(fontSize: 11, color: green),
                  ),
                ),
              ],
            ],
          ),
          if (r.comment.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(r.comment, style: const TextStyle(height: 1.4)),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = _all;
    final filtered =
        _filter == 0 ? all : all.where((r) => r.rating == _filter).toList();
    final shown = _showAll ? filtered : filtered.take(3).toList();
    final hasMine = _myReview != null;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ulasan Pembeli',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _summary(all),
          const SizedBox(height: 12),

          // Tombol tulis ulasan (abu-abu kalau pesanan belum selesai)
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton.icon(
              onPressed: _openForm,
              icon: Icon(
                hasMine ? Icons.edit_outlined : Icons.rate_review_outlined,
                color: widget.canReview ? green : Colors.grey,
                size: 20,
              ),
              label: Text(
                hasMine ? 'Ubah Ulasan Kamu' : 'Tulis Ulasan',
                style: TextStyle(
                  color: widget.canReview ? green : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: widget.canReview ? green : Colors.grey[400]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          if (!widget.canReview)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Ulasan hanya bisa ditulis setelah pesanan selesai',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          const SizedBox(height: 12),

          // Filter bintang
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final f in [0, 5, 4, 3, 2, 1])
                ChoiceChip(
                  label: Text(f == 0 ? 'Semua' : '$f ★'),
                  selected: _filter == f,
                  selectedColor: const Color(0xFFE5F6E6),
                  labelStyle: TextStyle(
                    color: _filter == f ? green : Colors.black87,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: _filter == f ? green : Colors.grey[300]!,
                  ),
                  onSelected: (_) => setState(() {
                    _filter = f;
                    _showAll = false;
                  }),
                ),
            ],
          ),
          const SizedBox(height: 16),

          if (filtered.isEmpty)
            Text(
              'Belum ada ulasan untuk filter ini',
              style: TextStyle(color: Colors.grey[600]),
            ),
          for (final r in shown) _reviewItem(r),

          if (filtered.length > 3)
            Center(
              child: TextButton(
                onPressed: () => setState(() => _showAll = !_showAll),
                child: Text(
                  _showAll
                      ? 'Lihat Lebih Sedikit'
                      : 'Lihat Semua Ulasan (${filtered.length})',
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}