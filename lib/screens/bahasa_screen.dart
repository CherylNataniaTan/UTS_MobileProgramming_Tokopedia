import 'package:flutter/material.dart';

import '../services/language_manager.dart';

class BahasaScreen extends StatelessWidget {
  const BahasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // realtime bahasa yang dipilih di seluruh halaman
    return ValueListenableBuilder<String>(
      valueListenable: LanguageManager.appLanguage,
      builder: (context, currentLang, child) {
        String appBarTitle = currentLang == 'en' ? 'Language' : 'Bahasa';

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: ListView(
            children: [
              ListTile(
                title: const Text('Indonesia'),
                trailing: currentLang == 'id'
                    ? const Icon(
                        Icons.check_circle,
                        color: Color.from(
                          alpha: 1,
                          red: 0.439,
                          green: 0.051,
                          blue: 0.106,
                        ),
                      )
                    : null,
                onTap: () async {
                  await LanguageManager.setLanguage('id');
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('English (US)'),
                trailing: currentLang == 'en'
                    ? const Icon(
                        Icons.check_circle,
                        color: Color.from(
                          alpha: 1,
                          red: 0.439,
                          green: 0.051,
                          blue: 0.106,
                        ),
                      )
                    : null,
                onTap: () async {
                  await LanguageManager.setLanguage('en');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
