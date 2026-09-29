import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../services/profile_storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel currentUser;

  const EditProfileScreen({super.key, required this.currentUser});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;

  String? _imagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController = TextEditingController(
      text: widget.currentUser.username,
    );
    _imagePath = widget.currentUser.profileImagePath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal membuka gallery atau memilih foto.'),
        ),
      );
    }
  }

  Future<void> _saveProfile() async {
    //buat validasi form
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final updatedUser = UserModel(
      name: _nameController.text.trim(),
      username: _usernameController.text.trim(),
      profileImagePath: _imagePath,
    );

    //nyimpan ke SharedPreferences
    final storageService = ProfileStorageService();
    await storageService.saveUserProfile(updatedUser);

    setState(() => _isLoading = false);

    if (mounted) {
      //balik ke halaman sebelumnya dengan data yang diperbarui
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.from(
          alpha: 1,
          red: 0.439,
          green: 0.051,
          blue: 0.106,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Foto Profile Preview
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.green.shade100,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : null,
                          child: _imagePath == null
                              ? Text(
                                  _nameController.text.isNotEmpty
                                      ? _nameController.text[0].toUpperCase()
                                      : 'U',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color.from(
                                      alpha: 1,
                                      red: 0.439,
                                      green: 0.051,
                                      blue: 0.106,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color.from(
                              alpha: 1,
                              red: 0.439,
                              green: 0.051,
                              blue: 0.106,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // PERBAIKAN: onTap diubah menjadi onPressed
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text(
                        'Ganti Foto',
                        style: TextStyle(
                          color: Color.from(
                            alpha: 1,
                            red: 0.439,
                            green: 0.051,
                            blue: 0.106,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Form buat nama
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Form Username
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final val = value?.trim();
                        if (val == null || val.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        if (val.length < 3) {
                          return 'Username minimal 3 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // Tombol Simpan dan Batal
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.from(
                                  alpha: 1,
                                  red: 0.439,
                                  green: 0.051,
                                  blue: 0.106,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                color: Color.from(
                                  alpha: 1,
                                  red: 0.439,
                                  green: 0.051,
                                  blue: 0.106,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.from(
                                alpha: 1,
                                red: 0.439,
                                green: 0.051,
                                blue: 0.106,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
