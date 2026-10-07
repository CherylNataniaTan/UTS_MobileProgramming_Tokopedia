import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

import '../screens/Alamat_Pengiriman_Screen.dart';

class ShippingAddressWidget extends StatefulWidget {
  const ShippingAddressWidget({super.key});

  @override
  State<ShippingAddressWidget> createState() =>
      _ShippingAddressWidgetState();
}

class _ShippingAddressWidgetState extends State<ShippingAddressWidget> {
  String selectedName = '';
  String selectedAddress = '';
  String selectedLabel = '';

  @override
  void initState() {
    super.initState();
    _loadAlamat();
  }

  Future<void> _loadAlamat() async {
    final prefs = await SharedPreferences.getInstance();

    final nama = prefs.getString('alamat_nama') ?? '';
    final provinsi = prefs.getString('alamat_provinsi') ?? '';
    final jalan = prefs.getString('alamat_jalan') ?? '';
    final detail = prefs.getString('alamat_detail') ?? '';
    final label = prefs.getString('alamat_label') ?? '';

    String alamat = '';

    if (jalan.isNotEmpty) {
      alamat = jalan;
    }

    if (detail.isNotEmpty) {
      if (alamat.isNotEmpty) {
        alamat += ', ';
      }
      alamat += detail;
    }

    if (provinsi.isNotEmpty) {
      if (alamat.isNotEmpty) {
        alamat += ', ';
      }
      alamat += provinsi;
    }

    if (!mounted) return;

    setState(() {
      selectedName = nama;
      selectedAddress = alamat;
      selectedLabel = label;
    });
  }

  Future<void> changeAddress() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AlamatPengirimanScreen(),
      ),
    );

    _loadAlamat();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAddress =
        selectedName.isNotEmpty && selectedAddress.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat Pengiriman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (hasAddress) ...[
            Row(
              children: [
                Text(
                  selectedLabel.isEmpty ? 'Alamat' : selectedLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            Text(
              selectedName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              selectedAddress,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ] else ...[
            const Text(
              'Belum ada alamat pengiriman',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Tambahkan alamat terlebih dahulu melalui Profile.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],

          const SizedBox(height: 10),

          TextButton(
            onPressed: changeAddress,
            child: Text(
              hasAddress ? 'Ubah Alamat' : 'Tambah Alamat',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}