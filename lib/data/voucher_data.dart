import '../models/voucher_model.dart';

final List<VoucherModel> userVouchers = [
  VoucherModel(
    code: 'HEMAT20',
    discount: '20%',
    description: 'Diskon maksimal Rp20.000',
  ),
  VoucherModel(
    code: 'GRATISONGKIR',
    discount: '100%',
    description: 'Bebas ongkir seluruh Indonesia',
  ),
  VoucherModel(
    code: 'CASHOFF50',
    discount: '50%',
    description: 'Cashback khusus pengguna baru',
  ),
];