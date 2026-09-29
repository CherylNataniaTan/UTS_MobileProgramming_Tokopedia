import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pusat Bantuan'), backgroundColor: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106),),
      body: const Center(child: Text( 'Akan segera hadir fitur pusat bantuan dan panduan penggunaan aplikasi.')),
    );
  }
}