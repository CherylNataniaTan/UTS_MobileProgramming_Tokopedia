import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlamatPengirimanScreen extends StatefulWidget {
  const AlamatPengirimanScreen({super.key});

  @override
  State<AlamatPengirimanScreen> createState() => _AlamatPengirimanScreenState();
}

class _AlamatPengirimanScreenState extends State<AlamatPengirimanScreen> {
  // Controller Form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _jalanController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  String _labelAlamat = 'Rumah';

  static const Color primaryRed = const Color.fromARGB(255, 112, 13, 27);

  @override
  void initState() {
    super.initState();
    _loadAlamatTersimpan();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _provinsiController.dispose();
    _jalanController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  //baca data dari shared preferences
  Future<void> _loadAlamatTersimpan() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaController.text = prefs.getString('alamat_nama') ?? '';
      _teleponController.text = prefs.getString('alamat_telepon') ?? '';
      _provinsiController.text = prefs.getString('alamat_provinsi') ?? '';
      _jalanController.text = prefs.getString('alamat_jalan') ?? '';
      _detailController.text = prefs.getString('alamat_detail') ?? '';
      _labelAlamat = prefs.getString('alamat_label') ?? 'Rumah';
    });
  }

  //nyimpan data ke shared preferences
  Future<void> _simpanAlamat() async {
    String nama = _namaController.text.trim();
    String telepon = _teleponController.text.trim();
    String provinsi = _provinsiController.text.trim();
    String jalan = _jalanController.text.trim();
    String detail = _detailController.text.trim();

    // Validasi input
    if (nama.isEmpty || telepon.isEmpty || jalan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi Nama, Nomor Telepon, dan Nama Jalan!'),
          backgroundColor: const Color.fromARGB(255, 112, 13, 27),
        ),
      );
      return;
    }

    // nyimpan
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alamat_nama', nama);
    await prefs.setString('alamat_telepon', telepon);
    await prefs.setString('alamat_provinsi', provinsi);
    await prefs.setString('alamat_jalan', jalan);
    await prefs.setString('alamat_detail', detail);
    await prefs.setString('alamat_label', _labelAlamat);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alamat berhasil disimpan!'),
        backgroundColor: const Color.fromARGB(255, 112, 13, 27),
      ),
    );
    Navigator.pop(context);
  }

  //buat maps
  void _pilihLokasiFromMap() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                size: 50,
                color: const Color.fromARGB(255, 112, 13, 27),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pinpoint Lokasi GPS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Jl. Letjen S. Parman No.1, Grogol, Jakarta Barat (Kampus UNTAR)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _provinsiController.text =
                        'DKI Jakarta, Jakarta Barat, Grogol Petamburan, 11440';
                    _jalanController.text =
                        'Jl. Letjen S. Parman No.1 (Kampus UNTAR)';
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lokasi GPS diterapkan ke form!'),
                      backgroundColor: const Color.fromARGB(255, 112, 13, 27),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 112, 13, 27),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text(
                  'Gunakan Lokasi Ini',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Alamat Anda', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row Nama Lengkap & Nomor Telepon
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _teleponController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Provinsi, Kota, Kecamatan
            TextField(
              controller: _provinsiController,
              decoration: const InputDecoration(
                labelText: 'Provinsi, Kota, Kecamatan, Kode Pos',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            const SizedBox(height: 16),

            // Nama Jalan
            TextField(
              controller: _jalanController,
              decoration: const InputDecoration(
                labelText: 'Nama Jalan, Gedung, No. Rumah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Detail Lainnya
            TextField(
              controller: _detailController,
              decoration: const InputDecoration(
                labelText: 'Detail Lainnya (Cth: Blok / Unit No., Patokan)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Map Placeholder
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _pilihLokasiFromMap,
                  icon: const Icon(Icons.add, color: Colors.grey),
                  label: const Text(
                    'Tambah Lokasi',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tandai Sebagai Rumah/Kantor
            const Text(
              'Tandai Sebagai:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Rumah'),
                  selected: _labelAlamat == 'Rumah',
                  selectedColor: primaryRed.withOpacity(0.2),
                  onSelected: (bool selected) {
                    setState(() {
                      _labelAlamat = 'Rumah';
                    });
                  },
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Kantor'),
                  selected: _labelAlamat == 'Kantor',
                  selectedColor: primaryRed.withOpacity(0.2),
                  onSelected: (bool selected) {
                    setState(() {
                      _labelAlamat = 'Kantor';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),

            //buat tombol simpan dan batal
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Nanti Saja',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _simpanAlamat,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 112, 13, 27),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
