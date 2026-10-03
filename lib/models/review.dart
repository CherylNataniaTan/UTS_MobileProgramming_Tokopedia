class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;

  const Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? 'Anonim',
    );
  }

  String get timeAgo {
    final d = DateTime.tryParse(date);
    if (d == null) return '';
    final diff = DateTime.now().difference(d);
    if (diff.inDays >= 365) return '${diff.inDays ~/ 365} tahun lalu';
    if (diff.inDays >= 30) return '${diff.inDays ~/ 30} bulan lalu';
    if (diff.inDays >= 7) return '${diff.inDays ~/ 7} minggu lalu';
    if (diff.inDays >= 1) return '${diff.inDays} hari lalu';
    return 'Hari ini';
  }
}