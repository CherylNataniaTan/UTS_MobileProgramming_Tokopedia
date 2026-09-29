import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil'), backgroundColor: Color.from(alpha: 1, red: 0.439, green: 0.051, blue: 0.106),),
      body: const Center(child: Text('Akan Segera hadir fitur edit profil pengguna.')),
    );
  }
}