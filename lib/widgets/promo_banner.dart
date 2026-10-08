import 'package:flutter/material.dart';

import '../screens/voucher_screen.dart';
import '../screens/flash_sale_screen.dart';
import '../models/voucher_model.dart';

final List<VoucherModel> _promoVouchers = [
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

class PromoItem {
  final String imageUrl;
  final String title;
  final String target;
 
  const PromoItem({
    required this.imageUrl, 
    required this.title, 
    required this.target,
  });
}

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}
 
class _PromoBannerState extends State<PromoBanner> {
  int currentIndex = 0;
 

 
  final List<PromoItem> banners =  const [
    PromoItem(
      imageUrl: 'assets/promobanner1.png',
      title: 'Promo Spesial Hari Ini!',
      target: 'voucher',
    ),
    PromoItem(
      imageUrl: 'assets/promobanner2.png',
      title: 'Flash Sale, Diskon Gede-gedean!',
      target: 'flashsale',
    ),
    PromoItem(
      imageUrl: 'assets/promobanner3.png',
      title: 'Diskon hingga 50% untuk Member Baru',
      target: 'voucher',
    ),
  ];
 
  void showNextBanner() {
    setState(() {
      currentIndex = (currentIndex + 1) % banners.length;
    });
  }
 
  void showPreviousBanner() {
    setState(() {
      currentIndex = (currentIndex - 1 + banners.length) % banners.length;
    });
  }
  
  void openBannerPage() {
    final target = banners[currentIndex].target;
 
    if (target == 'flashsale') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FlashSaleScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VoucherScreen(vouchers: _promoVouchers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     final banner = banners[currentIndex];
 
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          fit: StackFit.expand,
          children: [
          GestureDetector(
            onTap: openBannerPage,
            child: banner.imageUrl.startsWith('http')
                ? Image.network(
                    banner.imageUrl,
                    fit: BoxFit.cover,
                   )
                 : Image.asset(
                     banner.imageUrl,
                     fit: BoxFit.cover,
                   ),
),
  
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
              child: Center(
               child: GestureDetector(
                onTap: showPreviousBanner,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
              child: Center(
                child: GestureDetector(
                  onTap: showNextBanner,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}