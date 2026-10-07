import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class KeamananScreen extends StatefulWidget {
  const KeamananScreen({super.key});

  @override
  State<KeamananScreen> createState() => _KeamananScreenState();
}

class _KeamananScreenState extends State<KeamananScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();

  bool _isObscureOld = true;
  bool _isObscureNew = true;

  Future<void> _ubahPassword() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      //defaultnya 123456
      String savedPassword = prefs.getString('user_password') ?? '123456';

      //cek kata sandi lama
      if (_oldPassController.text != savedPassword) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kata sandi lama salah!'),
            backgroundColor: Color.from(
              alpha: 1,
              red: 0.439,
              green: 0.051,
              blue: 0.106,
            ),
          ),
        );
        return;
      }

      // Simpan password baru
      await prefs.setString('user_password', _newPassController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi berhasil diubah!'),
          backgroundColor: Color.from(
            alpha: 1,
            red: 0.439,
            green: 0.051,
            blue: 0.106,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color.from(
      alpha: 1,
      red: 0.439,
      green: 0.051,
      blue: 0.106,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Keamanan & Privasi',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ubah Kata Sandi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Kata Sandi Lama
              TextFormField(
                controller: _oldPassController,
                obscureText: _isObscureOld,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi Lama',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: primaryRed, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureOld ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _isObscureOld = !_isObscureOld),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),

              // Kata Sandi Baru
              TextFormField(
                controller: _newPassController,
                obscureText: _isObscureNew,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi Baru',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.from(
                        alpha: 1,
                        red: 0.439,
                        green: 0.051,
                        blue: 0.106,
                      ),
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureNew ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _isObscureNew = !_isObscureNew),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) return 'Tidak boleh kosong';
                  if (val.length < 6) return 'Minimal 6 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _ubahPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.from(
                    alpha: 1,
                    red: 0.439,
                    green: 0.051,
                    blue: 0.106,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan Kata Sandi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
