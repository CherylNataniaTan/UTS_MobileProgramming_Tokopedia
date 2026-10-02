import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  static const Color primaryRed = Color(0xFFA01626);

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}
 
class _PromoBannerState extends State<PromoBanner> {
  int currentIndex = 0;
 
  static const Color primaryRed = Color(0xFFA01626);
  static const Color darkRed = Color(0xFF700D1B);
 
  final List<String> banners = const [
    'Promo Spesial Hari Ini!',
    'Gratis Ongkir Se-Indonesia',
    'Diskon hingga 50% untuk Member Baru',
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
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: currentIndex.isEven ? primaryRed : darkRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            banners[currentIndex],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            left: 8,
            child: GestureDetector(
              onTap: showPreviousBanner,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Positioned(
            right: 8,
            child: GestureDetector(
              onTap: showNextBanner,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}