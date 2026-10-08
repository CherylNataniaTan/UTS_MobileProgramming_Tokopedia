class UntarPayTransaction {
  final String title;
  final int amount;
  final DateTime date;
  final bool isTopUp;

  UntarPayTransaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.isTopUp,
  });
}

class UntarPayData {
  static int balance = 200000;

  static final List<UntarPayTransaction> transactions = [];

  static String get formattedBalance {
    return 'Rp${balance.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  static String formatAmount(int amount) {
    return 'Rp${amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  static void addBalance(int amount) {
    balance += amount;

    transactions.insert(
      0,
      UntarPayTransaction(
        title: 'Top Up UntarPay',
        amount: amount,
        date: DateTime.now(),
        isTopUp: true,
      ),
    );
  }

  static bool deductBalance(int amount) {
    if (balance < amount) {
      return false;
    }

    balance -= amount;

    transactions.insert(
      0,
      UntarPayTransaction(
        title: 'Pembayaran',
        amount: amount,
        date: DateTime.now(),
        isTopUp: false,
      ),
    );

    return true;
  }
}